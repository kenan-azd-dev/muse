import 'package:flutter/material.dart';

// 3rd Party Packages

// Project Files

class ActivityView extends StatelessWidget {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Activity Page'),
        ),
      ),
    );
  }
}
