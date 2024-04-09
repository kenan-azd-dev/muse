import 'package:flutter/material.dart';

// Project Files
import '../../../core/utils/form_validator.dart';

class BioTextField extends StatelessWidget with Validator {
  const BioTextField({
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
      maxLength: 200,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        label: Text('Bio'),
      ),
      maxLines: 3,
      onChanged: _onChanged,
    );
  }
}
