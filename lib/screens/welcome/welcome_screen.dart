import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker_app/state/user_authentication_state.dart';
import 'package:gym_tracker_app/widgets/card_button.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff202730),
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              spacing: 12,
              children: [
                CardButton(
                  onTap: () {
                    ref
                        .read(userAuthenticationProvider.notifier)
                        .signInWithGoogle();
                  },
                  label: 'Sign In With Google',
                  icon: Icons.login_rounded,
                ),
                if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS)
                  CardButton(
                    onTap: () {
                      ref
                          .read(userAuthenticationProvider.notifier)
                          .signInWithApple();
                    },
                    label: 'Sign In With Apple',
                    icon: Icons.apple,
                  ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
