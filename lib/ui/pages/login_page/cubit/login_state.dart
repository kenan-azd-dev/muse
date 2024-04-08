part of 'login_cubit.dart';

enum LoginFormStatus {
  initial,
  loading,
  success,
  failure,
}

final class LoginState extends Equatable {
  const LoginState({
    this.inputCredential = '',
    this.password = '',
    this.status = LoginFormStatus.initial,
    this.obscureText = true,
    this.errorCode,
    this.isEmailValid = false,
    this.isUsernameValid = false,
    this.isPasswordValid = false,
  });

  final String inputCredential;
  final String password;
  final LoginFormStatus status;
  final bool obscureText;
  final String? errorCode;

  final bool isEmailValid;
  final bool isUsernameValid;
  final bool isPasswordValid;

  @override
  List<Object?> get props => [
        inputCredential,
        password,
        status,
        errorCode,
        obscureText,
        isEmailValid,
        isUsernameValid,
        isPasswordValid,
      ];

  LoginState copyWith({
    String? input,
    String? password,
    LoginFormStatus? status,
    bool? obscureText,
    String? errorCode,
    bool? isEmailValid,
    bool? isUsernameValid,
    bool? isPasswordValid,
  }) {
    return LoginState(
      inputCredential: input ?? this.inputCredential,
      password: password ?? this.password,
      status: status ?? this.status,
      obscureText: obscureText ?? this.obscureText,
      errorCode: errorCode,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    );
  }
}
