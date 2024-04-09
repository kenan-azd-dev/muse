import 'package:flutter/material.dart';

// Project Files
import '../../../core/utils/form_validator.dart';


class NameTextField extends StatelessWidget with Validator {
  const NameTextField({
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
      maxLength: 30,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        label: Text('Name'),
      ),
      validator: (value) => validateDisplayName(value),
      onChanged: _onChanged,
    );
  }
}