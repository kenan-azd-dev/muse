import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:flutter_bloc/flutter_bloc.dart';

// Project Files
import '../cubits/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';

class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      //this is very important, without it the whole screen will be blurred
      child: ClipRect(
        //I'm using BackdropFilter for the blurring effect
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10.0,
            sigmaY: 10.0,
          ),
          child: Opacity(
            opacity: 0.8,
            child: SizedBox(
              height: 83,
              child: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: context
                    .watch<BottomNavBarCubit>()
                    .state
                    .currentIndex,
                onTap: (int index) {
                  if (index == 2) {
                    return;
                  }
                  context
                      .read<BottomNavBarCubit>()
                      .navigateTo(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_filled,
                      color: Theme.of(context)
                          .colorScheme
                          .onInverseSurface,
                    ),
                    activeIcon: Icon(
                      Icons.home_filled,
                      color:
                          Theme.of(context).colorScheme.onSurface,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.globe,
                      color: Theme.of(context)
                          .colorScheme
                          .onInverseSurface,
                    ),
                    activeIcon: Icon(
                      CupertinoIcons.globe,
                      color:
                          Theme.of(context).colorScheme.onSurface,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: ElevatedButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.add_rounded,
                      ),
                      style: ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
                        backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.surface)
                      ),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite_rounded,
                      color: Theme.of(context)
                          .colorScheme
                          .onInverseSurface,
                    ),
                    label: '',
                    activeIcon: Icon(
                      Icons.favorite_rounded,
                      color:
                          Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_rounded,
                      color: Theme.of(context)
                          .colorScheme
                          .onInverseSurface,
                    ),
                    activeIcon: Icon(
                      Icons.person_rounded,
                      color:
                          Theme.of(context).colorScheme.onSurface,
                    ),
                    label: '',
                  ),
                ],
                type: BottomNavigationBarType.fixed,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

