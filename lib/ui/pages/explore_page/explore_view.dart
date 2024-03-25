import 'package:flutter/material.dart';

// 3rd Party Packages

// Project Files

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Explore Page'),
        ),
      ),
    );
  }
}
