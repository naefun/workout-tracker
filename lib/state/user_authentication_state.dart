import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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

  void _resetState({
    bool isSignedIn = false,
    String? firstName,
  }) {
    state = (
      isSignedIn: isSignedIn == true
          ? initialUserAuthenticationStateData.isSignedIn
          : state.isSignedIn,
      firstName: firstName ?? initialUserAuthenticationStateData.firstName,
    );
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

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _supabase.client.auth.signOut();
    _setState(isSignedIn: AuthStatus.signedOut);
  }

  void resetState() => state = initialUserAuthenticationStateData;
}
