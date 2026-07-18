import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker_app/state/user_authentication_state.dart';
import 'package:gym_tracker_app/widgets/card_button.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isDeletingAccount = false;

  Future<void> _deleteAccount() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete account?'),
        content: const Text(
          'This permanently deletes your account and all workout data. '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Delete account'),
          ),
        ],
      ),
    );

    if (shouldDelete != true || !mounted) {
      return;
    }

    setState(() => _isDeletingAccount = true);

    try {
      await ref.read(userAuthenticationProvider.notifier).deleteAccount();
    } catch (error, stackTrace) {
      log(
        'Account deletion failed.',
        error: error,
        stackTrace: stackTrace,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Your account could not be deleted. Please try again.',
          ),
        ),
      );
      setState(() => _isDeletingAccount = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 12,
            children: [
              CardButton(
                onTap: _isDeletingAccount ? () {} : _deleteAccount,
                label:
                    _isDeletingAccount ? 'Deleting account…' : 'Delete Account',
                icon: _isDeletingAccount
                    ? Icons.hourglass_top_rounded
                    : Icons.delete_forever_rounded,
                colour: Theme.of(context).colorScheme.errorContainer,
                iconColour: Theme.of(context).colorScheme.onErrorContainer,
                textColour: Theme.of(context).colorScheme.onErrorContainer,
              ),
              CardButton(
                onTap: _isDeletingAccount
                    ? () {}
                    : () {
                        ref.read(userAuthenticationProvider.notifier).signOut();
                      },
                label: 'Sign Out',
                icon: Icons.logout_rounded,
              ),
            ],
          ),
        )
      ],
    ));
  }
}
