import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    void Function(String)? onChanged,
    String label = 'Password',
    bool obscureText = true,
    String? Function(String?)? validator,
    required void Function()? onObscurePressed,
  })  : _label = label,
        _obscureText = obscureText,
        _onChanged = onChanged,
        _validator = validator,
        _onObscurePressed = onObscurePressed;
  final String _label;
  final void Function(String)? _onChanged;
  final bool _obscureText;
  final void Function()? _onObscurePressed;
  final String? Function(String?)? _validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: _onChanged,
      textInputAction: TextInputAction.next,
      obscureText: _obscureText,
      onFieldSubmitted: (value) {
        //print('============================================');
      },
      decoration: InputDecoration(
        label: Text(_label),
        prefixIcon: const Icon(Icons.password_rounded),
        suffixIcon: _obscureText
            ? IconButton(
                icon: const Icon(Icons.visibility_off_rounded),
                onPressed: _onObscurePressed,
              )
            : IconButton(
                icon: const Icon(Icons.visibility_rounded),
                onPressed: _onObscurePressed,
              ),
      ),
      validator: _validator,
    );
  }
}
