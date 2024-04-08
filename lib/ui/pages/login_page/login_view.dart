import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:muse/ui/blocs/app_user_bloc/user_bloc.dart';

// Project Files
import '../../../core/router/router.dart';
import '../../widgets/language_drop_down_button.dart';
import '../../widgets/text_fields/text_fields.dart';
import './cubit/login_cubit.dart';
import './widgets/login_button.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state.status == LoginFormStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorCode ?? 'Authentication Failure'),
              ),
            );
        }
        if (state.status == LoginFormStatus.success) {
          // Navigator.pushReplacementNamed(context, homePage);
          context.read<AppUserBloc>().add(const UserProfileFetched());
        }
      }, builder: (context, state) {
        return Builder(
          builder: (context) {
            final appUserBloc = context.read<AppUserBloc>();
            if (appUserBloc.state.status == UserStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.status == LoginFormStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height - kToolbarHeight,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 8.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const LanguageDropdownButton(),
                          const Spacer(),
                          Text(
                            'Muse',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(fontFamily: 'Billabong'),
                          ),
                          const Gap(32.0),
                          EmailTextField(
                            onChanged: (value) => context
                                .read<LoginCubit>()
                                .updateEmailOrUsername(value),
                          ),
                          const Gap(18.0),
                          PasswordTextField(
                            onObscurePressed: () =>
                                context.read<LoginCubit>().toggleObscureText(),
                            obscureText: context.select<LoginCubit, bool>(
                                (value) => value.state.obscureText),
                            onChanged: (value) => context
                                .read<LoginCubit>()
                                .updatePassword(value),
                          ),
                          const Gap(24.0),
                          const LoginButton(),
                          const Gap(10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Forgot your login details? ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(8.0),
                                onTap: () {},
                                child: Text(
                                  'Click here.',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(24.0),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  width: double.maxFinite,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outlineVariant,
                                ),
                              ),
                              const Gap(8.0),
                              const Text(
                                'OR',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const Gap(8.0),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  width: double.maxFinite,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outlineVariant,
                                ),
                              ),
                            ],
                          ),
                          const Gap(12.0),
                          const LoginWithGoogleButton(),
                          const Gap(12.0),
                          const Divider(),
                          const Gap(12.0),
                          const _SignUpNavigation(),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        );
      }),
    );
  }
}

class _SignUpNavigation extends StatelessWidget {
  const _SignUpNavigation();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account? ',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () => Navigator.pushReplacementNamed(context, signUpPage),
          child: Text(
            'Sign up',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class LoginWithGoogleButton extends StatelessWidget {
  const LoginWithGoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 50,
      child: TextButton(
        onPressed: () {
          context.read<LoginCubit>().logInWithGoogle();
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.google),
            Gap(8.0),
            Text('Login with Google'),
            Gap(8.0),
          ],
        ),
      ),
    );
  }
}
