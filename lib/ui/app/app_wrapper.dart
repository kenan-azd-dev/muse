import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:flutter_bloc/flutter_bloc.dart';

// Project Files
import '../blocs/app_user_bloc/user_bloc.dart';
import '/di/injection_container.dart';
import '../../core/common/common.dart';

import './app.dart';

class MuseApp extends StatelessWidget {
  const MuseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (context) => locator()),
        BlocProvider<AppUserBloc>(
            create: (context) => locator()..add(const UserProfileFetched())),
      ],
      child: const Core(),
    );
  }
}
