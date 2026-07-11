import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker_app/screens/welcome/welcome_screen.dart';
import 'package:gym_tracker_app/state/user_authentication_state.dart';
import 'package:gym_tracker_app/util/color_utils.dart';

class AuthenticatorController extends ConsumerStatefulWidget {
  const AuthenticatorController({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthenticatorControllerState();
}

class _AuthenticatorControllerState
    extends ConsumerState<AuthenticatorController> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .read(userAuthenticationProvider.notifier)
          .signInWithGoogle(silentOnly: true);

      log('Silent auth check');
    });
  }

  @override
  Widget build(BuildContext context) {
    final signedInStatus = ref.watch(userAuthenticationProvider).isSignedIn;

    return switch (signedInStatus) {
      AuthStatus.unknown => Scaffold(
          backgroundColor: Color(0xff202730),
          body: Center(child: CircularProgressIndicator(color: primaryColour)),
        ),
      AuthStatus.signedIn => widget.child,
      AuthStatus.signedOut => const WelcomeScreen(),
    };
  }
}
