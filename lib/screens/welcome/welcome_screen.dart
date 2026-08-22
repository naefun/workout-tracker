import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker_app/state/user_authentication_state.dart';
import 'package:gym_tracker_app/util/color_utils.dart';
import 'package:gym_tracker_app/util/privacy_policy.dart';
import 'package:gym_tracker_app/widgets/card_button.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool _isSigningIn = false;

  Future<void> _openPrivacyPolicy() async {
    final opened = await openPrivacyPolicy();

    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to open the privacy policy.'),
        ),
      );
    }
  }

  Future<void> _signIn(Future<void> Function() signIn) async {
    if (_isSigningIn) {
      return;
    }

    setState(() => _isSigningIn = true);

    try {
      await signIn();
    } catch (error, stackTrace) {
      log(
        'Login was unsuccessful.',
        error: error,
        stackTrace: stackTrace,
      );

      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'Login was unsuccessful. Check your connection and try again.',
              ),
            ),
          );
      }
    } finally {
      if (mounted) {
        setState(() => _isSigningIn = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff202730),
      body: SafeArea(
        child: _isSigningIn
            ? Center(
                child: CircularProgressIndicator(color: primaryColour),
              )
            : Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      spacing: 12,
                      children: [
                        CardButton(
                          onTap: () => _signIn(
                            ref
                                .read(userAuthenticationProvider.notifier)
                                .signInWithGoogle,
                          ),
                          label: 'Sign In With Google',
                          icon: Icons.g_mobiledata_rounded,
                        ),
                        if (!kIsWeb &&
                            defaultTargetPlatform == TargetPlatform.iOS)
                          CardButton(
                            onTap: () => _signIn(
                              ref
                                  .read(userAuthenticationProvider.notifier)
                                  .signInWithApple,
                            ),
                            label: 'Sign In With Apple',
                            icon: Icons.apple,
                          ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: _openPrivacyPolicy,
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(color: primaryColour),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
      ),
    );
  }
}
