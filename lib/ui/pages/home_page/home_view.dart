import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:flutter_bloc/flutter_bloc.dart';

// Project Files
import '../../blocs/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import '../../blocs/home_page_view_cubit/home_page_view_cubit.dart';
import '../feed_page/feed_page.dart';
import '../profile_page/profile_page.dart';
import './widgets/main_bottom_nav_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController(initialPage: 1);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
    return BlocConsumer<HomePageViewCubit, HomePageViewState>(
      listener: (context, state) {
        if (state.currentIndex == 2) {
          _pageController.animateToPage(
            2,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
      builder: (context, state) {
        return PageView(
          physics: context.watch<BottomNavBarCubit>().state.currentIndex != 0
              ? const NeverScrollableScrollPhysics()
              : null,
          controller: _pageController,
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
      },
    );
  }
}
