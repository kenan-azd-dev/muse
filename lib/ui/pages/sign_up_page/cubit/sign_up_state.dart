part of 'sign_up_cubit.dart';

enum SignUpFormStatus {
  initial,
  loading,
  success,
  failure,
}

final class SignUpState extends Equatable {
  const SignUpState({
    this.email = '',
    this.confirmPassword = '',
    this.password = '',
    this.status = SignUpFormStatus.initial,
    this.obscureText = true,
    this.errorCode,
    this.isEmailValid = false,
    this.isConfirmPasswordValid = false,
    this.isPasswordValid = false,
    required this.userProfile,
  });

  final String email;
  final String confirmPassword;
  final String password;
  final SignUpFormStatus status;
  final bool obscureText;
  final String? errorCode;
  final UserProfile userProfile;

  final bool isEmailValid;
  final bool isConfirmPasswordValid;
  final bool isPasswordValid;

  @override
  List<Object?> get props => [
        email,
        confirmPassword,
        password,
        status,
        errorCode,
        obscureText,
        isEmailValid,
        isConfirmPasswordValid,
        isPasswordValid,
        userProfile,
      ];

  SignUpState copyWith({
    String? email,
    String? confirmPassword,
    String? password,
    SignUpFormStatus? status,
    bool? obscureText,
    String? errorCode,
    bool? isEmailValid,
    bool? isConfirmPasswordValid,
    bool? isPasswordValid,
    UserProfile? userProfile,
  }) {
    return SignUpState(
      email: email ?? this.email,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      password: password ?? this.password,
      status: status ?? this.status,
      obscureText: obscureText ?? this.obscureText,
      errorCode: errorCode,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isConfirmPasswordValid: isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
