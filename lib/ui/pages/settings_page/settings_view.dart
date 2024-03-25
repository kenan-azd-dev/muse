import 'package:flutter/material.dart';

// 3rd Party Packages

// Project Files

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Settings Page'),
        ),
      ),
    );
  }
}
