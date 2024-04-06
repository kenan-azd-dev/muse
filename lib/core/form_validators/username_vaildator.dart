import 'package:formz/formz.dart';

/// Validation errors for the [Username] [FormzInput].
enum UsernameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template username}
/// Form input for a username input.
/// {@endtemplate}
class Username extends FormzInput<String, UsernameValidationError> {
  /// {@macro username}
  const Username.pure() : super.pure('');

  /// {@macro username}
  const Username.dirty([super.value = '']) : super.dirty();

  static final RegExp _usernameRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  UsernameValidationError? validator(String? value) {
    return _usernameRegExp.hasMatch(value ?? '')
        ? null
        : UsernameValidationError.invalid;
  }
}