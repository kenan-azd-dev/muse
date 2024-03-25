import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:flutter_bloc/flutter_bloc.dart';


// Project Files
import '../../blocs/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import '../feed_page/feed_page.dart';
import '../profile_page/profile_page.dart';
import './widgets/main_bottom_nav_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const FeedPage(),
      const Text(
        'Index 1: Business',
      ),
      const Text(
        'Index 2: School',
      ),
      const Text(
        'Index 3: Settings',
      ),
      const ProfilePage()
    ];
    return PageView(
      physics: context.watch<BottomNavBarCubit>().state.currentIndex != 0
          ? const NeverScrollableScrollPhysics()
          : null,
      // TODO: dispose of this controller
      controller: PageController(initialPage: 1),
      pageSnapping: true,
      children: [
        const Scaffold(),
        Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                widgetOptions.elementAt(
                    context.watch<BottomNavBarCubit>().state.currentIndex),
                const MainBottomNavBar(),
              ],
            ),
          ),
        ),
        const Scaffold(),
      ],
    );
  }
}
