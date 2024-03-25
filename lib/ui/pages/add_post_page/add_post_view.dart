import 'package:flutter/material.dart';

// 3rd Party Packages

// Project Files

class AddPostView extends StatelessWidget {
  const AddPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Add Post Page'),
        ),
      ),
    );
  }
}
