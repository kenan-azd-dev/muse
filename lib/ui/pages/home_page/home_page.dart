import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:flutter_bloc/flutter_bloc.dart';

// Project Files
import '../../blocs/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import '../../blocs/home_page_view_cubit/home_page_view_cubit.dart';
import './home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavBarCubit(),
        ),
        BlocProvider(
          create: (context) => HomePageViewCubit(),
        ),
      ],
      child: const HomeView(),
    );
  }
}
