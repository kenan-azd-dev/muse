
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project Files
import '../../../../core/theme/theme.dart';
import '../../home_page/cubits/home_page_view_cubit/home_page_view_cubit.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: [
          const Text(
            'Muse',
            style: AppTheme.mainAppBarTextStyle,
          ),
          const Spacer(),
          IconButton(
            onPressed: () => context.read<HomePageViewCubit>().navigateTo(2),
            icon: const Icon(CupertinoIcons.bubble_right_fill),
          )
        ],
      ),
    );
  }
}
