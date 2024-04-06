import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  })  : _onChanged = onChanged,
        _validator = validator;

  final void Function(String)? _onChanged;
  final String? Function(String?)? _validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        label: Text('Email'),
        prefixIcon: Icon(Icons.email_rounded),
      ),
      onChanged: _onChanged,
      validator: _validator,
    );
  }
}
