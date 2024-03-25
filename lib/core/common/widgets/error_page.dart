import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    String message = 'An error occurred',
  }) : _message = message;

  final String _message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_message),
      ),
    );
  }
}
