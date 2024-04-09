import 'package:flutter/material.dart';

// Project Files
import '../../../core/utils/form_validator.dart';

class UsernameTextField extends StatelessWidget with Validator {
  const UsernameTextField({
    super.key,
    void Function(String)? onChanged,
    String? initialValue,
  })  : _onChanged = onChanged,
        _initialValue = initialValue;

  final void Function(String)? _onChanged;
  final String? _initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: _initialValue,
      textInputAction: TextInputAction.next,
      maxLength: 30,
      decoration: const InputDecoration(
        label: Text('Username'),
      ),
      validator: (value) => validateUsername(value),
      onChanged: _onChanged,
    );
  }
}
