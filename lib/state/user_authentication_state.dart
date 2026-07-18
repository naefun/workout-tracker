import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_tracker_app/state/current_tab_state.dart';
import 'package:gym_tracker_app/state/current_workout_state.dart';
import 'package:gym_tracker_app/state/database_state.dart';
import 'package:gym_tracker_app/state/past_workouts_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_authentication_state.g.dart';

enum AuthStatus {
  unknown,
  signedIn,
  signedOut,
}

typedef UserAuthenticationStateData = ({
  AuthStatus isSignedIn,
  String? firstName,
});

const UserAuthenticationStateData initialUserAuthenticationStateData =
    (isSignedIn: AuthStatus.unknown, firstName: null);

@Riverpod(keepAlive: true)
class UserAuthenticationNotifier extends _$UserAuthenticationNotifier {
  late final GoogleSignIn _googleSignIn;
  late final Supabase _supabase;

  @override
  UserAuthenticationStateData build() {
    _googleSignIn = GoogleSignIn.instance;
    _supabase = Supabase.instance;
    return initialUserAuthenticationStateData;
  }

  void _setState({
    AuthStatus? isSignedIn,
    String? firstName,
  }) {
    state = (
      isSignedIn: isSignedIn ?? state.isSignedIn,
      firstName: firstName ?? state.firstName,
    );
  }

  void _resetSignedOutState() {
    ref.read(currentWorkoutProvider.notifier).resetState();
    ref.read(pastWorkoutsProvider.notifier).resetState();
    ref.read(currentTabProvider.notifier).resetState();
    state = (
      isSignedIn: AuthStatus.signedOut,
      firstName: initialUserAuthenticationStateData.firstName,
    );
  }

  Future<void> restoreSession() async {
    final user = _supabase.client.auth.currentUser;
    if (user != null) {
      final fullName = (user.userMetadata?['full_name'] ??
          user.userMetadata?['name']) as String?;
      _setState(
        isSignedIn: AuthStatus.signedIn,
        firstName: fullName?.split(' ').first,
      );
      return;
    }

    await signInWithGoogle(silentOnly: true);
  }

  Future<void> signInWithGoogle({bool silentOnly = false}) async {
    GoogleSignInAccount? googleUser;
    if (silentOnly) {
      googleUser = await _googleSignIn.attemptLightweightAuthentication();
    }
    if (googleUser == null && !silentOnly) {
      try {
        googleUser = await _googleSignIn.authenticate();
      } catch (e) {
        log(e.toString());
      }
    }

    if (googleUser == null) {
      log('Failed to sign in with Google.');
      _setState(isSignedIn: AuthStatus.signedOut);
      return;
    }

    final scopes = ['email', 'profile'];

    final authorization =
        await googleUser.authorizationClient.authorizationForScopes(scopes) ??
            await googleUser.authorizationClient.authorizeScopes(scopes);
    final idToken = googleUser.authentication.idToken;
    if (idToken == null) {
      throw Exception('No ID Token found.');
    }
    final response = await _supabase.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: authorization.accessToken,
    );

    if (response.session != null && response.user != null) {
      log('Successfully signed in with Google and authenticated with Supabase.');
      _setState(
          isSignedIn: AuthStatus.signedIn,
          firstName: (response.user?.userMetadata?['name'] as String?)
              ?.split(' ')
              .first);
      return;
    } else {
      log('Failed to authenticate with Supabase using Google credentials.');
      _setState(isSignedIn: AuthStatus.signedOut);
      return;
    }
  }

  Future<void> signInWithApple() async {
    try {
      final rawNonce = _supabase.client.auth.generateRawNonce();
      final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );
      final idToken = credential.identityToken;

      if (idToken == null) {
        throw const AuthException(
          'Could not find an ID token in the Apple credential.',
        );
      }

      final response = await _supabase.client.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
        nonce: rawNonce,
      );

      if (response.session == null || response.user == null) {
        log('Failed to authenticate with Supabase using Apple credentials.');
        _setState(isSignedIn: AuthStatus.signedOut);
        return;
      }

      final givenName = credential.givenName?.trim();
      final familyName = credential.familyName?.trim();
      final fullName = [givenName, familyName]
          .whereType<String>()
          .where((name) => name.isNotEmpty)
          .join(' ');

      if (fullName.isNotEmpty) {
        await _supabase.client.auth.updateUser(
          UserAttributes(
            data: {
              'full_name': fullName,
              if (givenName?.isNotEmpty ?? false) 'given_name': givenName,
              if (familyName?.isNotEmpty ?? false) 'family_name': familyName,
            },
          ),
        );
      }

      log('Successfully signed in with Apple and authenticated with Supabase.');
      _setState(
        isSignedIn: AuthStatus.signedIn,
        firstName: givenName ??
            (response.user?.userMetadata?['full_name'] as String?)
                ?.split(' ')
                .first,
      );
    } on SignInWithAppleAuthorizationException catch (error) {
      if (error.code != AuthorizationErrorCode.canceled) {
        log('Apple sign in failed: $error');
      }
      _setState(isSignedIn: AuthStatus.signedOut);
    } catch (error) {
      log('Apple sign in failed: $error');
      _setState(isSignedIn: AuthStatus.signedOut);
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } finally {
      try {
        await _supabase.client.auth.signOut();
      } finally {
        _resetSignedOutState();
      }
    }
  }

  Future<void> deleteAccount() async {
    final response = await _supabase.client.functions.invoke('delete-account');
    final responseData = response.data;
    final deletionConfirmed = response.status == 200 &&
        responseData is Map<String, dynamic> &&
        responseData['deleted'] == true;

    if (!deletionConfirmed) {
      throw StateError('Supabase did not confirm account deletion.');
    }

    try {
      await ref.read(databaseProvider).database?.deleteAllUserData();
    } catch (error, stackTrace) {
      log(
        'The Supabase account was deleted, but local data cleanup failed.',
        error: error,
        stackTrace: stackTrace,
      );
    }

    try {
      await _googleSignIn.disconnect();
    } catch (error, stackTrace) {
      log(
        'The Google authorization could not be disconnected.',
        error: error,
        stackTrace: stackTrace,
      );
    }

    try {
      await _supabase.client.auth.signOut(scope: SignOutScope.local);
    } finally {
      _resetSignedOutState();
    }
  }

  void resetState() => state = initialUserAuthenticationStateData;
}
