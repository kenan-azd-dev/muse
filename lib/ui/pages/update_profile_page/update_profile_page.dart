
// 3rd Party Packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project Files
import '../../../di/injection_container.dart';
import 'update_profile_view.dart';
import 'cubit/update_profile_cubit.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpdateProfileCubit>(
      create: (context) => locator(),
      child: EditProfileView(),
    );
  }
}
