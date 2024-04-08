import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:flutter_bloc/flutter_bloc.dart';

// Project Files
import '../../../di/injection_container.dart';
import 'create_profile_view.dart';
import 'cubit/create_profile_cubit.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({
    super.key,
    required String email,
    required String password,
  })  : _email = email,
        _password = password;

  final String _email;
  final String _password;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateProfileCubit>(
      create: (context) => locator(),
      child: CreateAccountView(
        email: _email,
        password: _password,
      ),
    );
  }
}
