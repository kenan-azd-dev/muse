import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 3rd Party Packages
import 'package:gap/gap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:muse/core/router/arguments/sign_up_arguments.dart';

// Project Files
import '../../../core/router/router.dart';
import '../../../core/utils/form_validator.dart';
import '../../widgets/language_drop_down_button.dart';
import '../../widgets/text_fields/text_fields.dart';
import 'cubit/sign_up_cubit.dart';

class SignUpView extends StatelessWidget with Validator {
  SignUpView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 8.0,
            ),
            child: BlocConsumer<SignUpCubit, SignUpState>(
                listener: (context, state) {
              if (state.status == SignUpFormStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content:
                          Text(state.errorCode ?? 'Authentication Failure'),
                    ),
                  );
              }
              if (state.status == SignUpFormStatus.success) {
                Navigator.pushReplacementNamed(context, homePage);
              }
            }, builder: (context, state) {
              if (state.status == SignUpFormStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Form(
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
                        onChanged: (value) =>
                            context.read<SignUpCubit>().updateEmail(value),
                        validator: (value) => validateEmail(value),
                      ),
                      const Gap(18.0),
                      PasswordTextField(
                        onObscurePressed: () =>
                            context.read<SignUpCubit>().toggleObscureText(),
                        obscureText: context.select<SignUpCubit, bool>(
                            (value) => value.state.obscureText),
                        onChanged: (value) =>
                            context.read<SignUpCubit>().updatePassword(value),
                        validator: (value) => validatePassword(value),
                      ),
                      const Gap(18.0),
                      PasswordTextField(
                        onObscurePressed: () =>
                            context.read<SignUpCubit>().toggleObscureText(),
                        obscureText: context.select<SignUpCubit, bool>(
                            (value) => value.state.obscureText),
                        onChanged: (value) => context
                            .read<SignUpCubit>()
                            .updateConfirmPassword(value),
                        label: 'Confirm Password',
                        validator: (value) => validateConfirmPassword(
                          value,
                          context.read<SignUpCubit>().state.password,
                        ),
                      ),
                      const Gap(24.0),
                      SizedBox(
                        width: double.maxFinite,
                        height: 64,
                        child: OutlinedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            final args = SignUpArguments(
                              email: context.read<SignUpCubit>().state.email,
                              password: context.read<SignUpCubit>().state.email,
                            );
                            Navigator.pushNamed(
                              context,
                              createAccountPage,
                              arguments: args,
                            );
                          },
                          child: const Text('Sign up'),
                        ),
                      ),
                      const Gap(24.0),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              width: double.maxFinite,
                              color:
                                  Theme.of(context).colorScheme.outlineVariant,
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
                              color:
                                  Theme.of(context).colorScheme.outlineVariant,
                            ),
                          ),
                        ],
                      ),
                      const Gap(12.0),
                      SizedBox(
                        width: double.maxFinite,
                        height: 50,
                        child: TextButton(
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.google),
                              Gap(8.0),
                              Text('Sign up with Google'),
                              Gap(8.0),
                            ],
                          ),
                        ),
                      ),
                      const Gap(12.0),
                      const Divider(),
                      const Gap(12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(8.0),
                            onTap: () => Navigator.pushReplacementNamed(
                                context, loginPage),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
