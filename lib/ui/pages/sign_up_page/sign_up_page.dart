import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project Files
import '../../../di/injection_container.dart';
import './sign_up_view.dart';
import 'cubit/sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => locator<SignUpCubit>(),
      child: SignUpView(),
    );
  }
}
