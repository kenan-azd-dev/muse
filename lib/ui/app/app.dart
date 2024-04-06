import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:flutter_bloc/flutter_bloc.dart';

// Project Files
import '../../core/common/common.dart';
import '../../core/theme/theme.dart';
import '../../core/router/router.dart';
import '../blocs/app_user_bloc/user_bloc.dart';
import '../pages/home_page/home_page.dart';
import '../pages/login_page/login_page.dart';

class Core extends StatelessWidget {
  const Core({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muse',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => Routing.generateRoute(settings),
      themeMode: context.read<ThemeCubit>().state.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: BlocBuilder<AppUserBloc, AppUserState>(
        builder: (context, state) {
          if (state.status == UserStatus.authenticated) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
