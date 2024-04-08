import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:muse/core/router/router.dart';

import '../../blocs/app_user_bloc/user_bloc.dart';

class ProfileCompletedView extends StatelessWidget {
  const ProfileCompletedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: BlocConsumer<AppUserBloc, AppUserState>(
            listener: (context, state) {
              if (state.status == UserStatus.authenticated) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  homePage,
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Profile Completed!',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .scale(
                        begin: const Offset(0, 0),
                        end: const Offset(0.8, 0.8),
                        curve: Curves.easeOutCubic,
                        duration: const Duration(milliseconds: 1000),
                      )
                      .rotate(
                        begin: 0,
                        end: -0.10,
                        curve: Curves.easeOutCubic,
                      )
                      .rotate(
                        begin: 0,
                        end: 0.10,
                        curve: Curves.easeInCubic,
                        delay: const Duration(milliseconds: 500),
                      )
                      .scale(
                        begin: const Offset(1.0, 1.0),
                        end: const Offset(0.8, 0.8),
                        curve: Curves.easeInCubic,
                      )
                      .shake(
                        delay: const Duration(milliseconds: 1200),
                        duration: const Duration(milliseconds: 500),
                      )
                      .shimmer(
                        delay: const Duration(milliseconds: 1600),
                        color: Colors.grey,
                        duration: const Duration(milliseconds: 1000),
                      ),
                  Text(
                    'You\'re all set! Enjoy using our app.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ).animate().fadeIn(
                        delay: const Duration(milliseconds: 2000),
                        duration: const Duration(milliseconds: 500),
                      ),
                  const Gap(32),
                  SizedBox(
                    height: 64,
                    width: double.maxFinite,
                    child: OutlinedButton(
                      onPressed: state.status == UserStatus.loading
                          ? null
                          : () => BlocProvider.of<AppUserBloc>(context)
                              .add(const UserProfileFetched()),
                      child: state.status == UserStatus.loading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Continue'),
                    ),
                  ).animate().fadeIn(
                        delay: const Duration(milliseconds: 2000),
                        duration: const Duration(milliseconds: 500),
                      )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
