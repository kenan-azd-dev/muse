// 3rd Party Packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project Files
import '../../../../core/utils/form_validator.dart';
import '../../../../data/auth/repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginState());

  final AuthRepository _authRepository;

  void toggleObscureText() {
    emit(state.copyWith(
      obscureText: !state.obscureText,
      status: LoginFormStatus.initial,
    ));
  }

  void updateEmailOrUsername(String? emailOrUsername) {
    emit(
      state.copyWith(
        email: emailOrUsername,
        username: emailOrUsername,
        isEmailValid: Validator.isEmailValid(emailOrUsername ?? ''),
        isUsernameValid: Validator.isUsernameValid(emailOrUsername ?? ''),
        status: LoginFormStatus.initial,
      ),
    );
  }

  void updatePassword(String? password) {
    emit(
      state.copyWith(
        password: password,
        isPasswordValid: Validator.isPasswordValid(password ?? ''),
        status: LoginFormStatus.initial,
      ),
    );
  }

  Future<void> logInWithEmailAndPassword() async {
    if (!state.isEmailValid) return;
    emit(state.copyWith(status: LoginFormStatus.loading));
    final result = await _authRepository.logInWithEmailAndPassword(
      email: state.email,
      password: state.password,
    );
    emit(
      result.fold(
        (failure) => state.copyWith(
          errorCode: failure.code,
          status: LoginFormStatus.failure,
        ),
        (_) => state.copyWith(status: LoginFormStatus.success),
      ),
    );
  }

  Future<void> logInWithUsernameAndPassword() async {
    if (!state.isUsernameValid) return;
    emit(state.copyWith(status: LoginFormStatus.loading));
    final result = await _authRepository.logInWithUsernameAndPassword(
      username: state.username,
      password: state.password,
    );
    emit(
      result.fold(
        (failure) => state.copyWith(
          errorCode: failure.code,
          status: LoginFormStatus.failure,
        ),
        (_) => state.copyWith(status: LoginFormStatus.success),
      ),
    );
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: LoginFormStatus.loading));
    final result = await _authRepository.logInWithGoogle();
    emit(
      result.fold(
        (failure) => state.copyWith(
          errorCode: failure.code,
          status: LoginFormStatus.failure,
        ),
        (_) => state.copyWith(status: LoginFormStatus.success),
      ),
    );
  }
}
