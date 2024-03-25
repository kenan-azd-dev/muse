
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project Files
import '../../../../core/core.dart';

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
            onPressed: () {},
            icon: const Icon(CupertinoIcons.bubble_right_fill),
          )
        ],
      ),
    );
  }
}
