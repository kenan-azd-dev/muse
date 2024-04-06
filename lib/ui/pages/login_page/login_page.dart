import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:flutter_bloc/flutter_bloc.dart';

// Project Files
import '../../../di/injection_container.dart';
import './login_view.dart';
import './cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => locator<LoginCubit>(),
      child: LoginView(),
    );
  }
}
