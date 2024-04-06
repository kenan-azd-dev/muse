import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project Files
import '../cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 64,
      child: OutlinedButton(
        onPressed: () {
          final blocProvider = context.read<LoginCubit>();
          if (blocProvider.state.isEmailValid &&
              blocProvider.state.isPasswordValid) {
            blocProvider.logInWithEmailAndPassword();
          } else if (blocProvider.state.isUsernameValid &&
              blocProvider.state.isPasswordValid) {
            blocProvider.logInWithUsernameAndPassword();
          }
        },
        child: const Text('Login'),
      ),
    );
  }
}
