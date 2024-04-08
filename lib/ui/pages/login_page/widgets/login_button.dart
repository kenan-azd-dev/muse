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
        onPressed: () async {
          final blocProvider = context.read<LoginCubit>();
          if (blocProvider.state.isPasswordValid) {
            await blocProvider.logIn();
          }
        },
        child: const Text('Login'),
      ),
    );
  }
}
