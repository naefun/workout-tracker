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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColour.withValues(alpha: 0.35),
                                  blurRadius: 40,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(36),
                              child: Image.asset(
                                'assets/icon/icon.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),
                          const Text(
                            'Welcome',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Track your workouts. Crush your goals.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
