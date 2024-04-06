// 3rd Party Packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muse/core/models/models.dart';

// Project Files
import '../../../../core/utils/form_validator.dart';
import '../../../../data/auth/repository/auth_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepository) : super(const SignUpState());

  final AuthRepository _authRepository;

  void toggleObscureText() {
    emit(state.copyWith(
      obscureText: !state.obscureText,
      status: SignUpFormStatus.initial,
    ));
  }

  void updateEmail(String? email) {
    emit(
      state.copyWith(
        email: email,
        isEmailValid: Validator.isEmailValid(email ?? ''),
      ),
    );
  }

  void updatePassword(String? password) {
    emit(
      state.copyWith(
        password: password,
        isPasswordValid: Validator.isPasswordValid(password ?? ''),
      ),
    );
  }

  void updateConfirmPassword(String? password) {
    emit(
      state.copyWith(
        confirmPassword: password,
        isConfirmPasswordValid: Validator.isPasswordValid(password ?? ''),
      ),
    );
  }

  Future<void> signUp() async {
    if (!state.isEmailValid || state.userProfile.isEmpty) return;
    emit(state.copyWith(status: SignUpFormStatus.loading));
    final result = await _authRepository.signUp(
      email: state.email,
      password: state.password,
      userProfile: state.userProfile,
    );
    emit(
      result.fold(
        (failure) => state.copyWith(
          errorCode: failure.code,
          status: SignUpFormStatus.failure,
        ),
        (_) => state.copyWith(status: SignUpFormStatus.success),
      ),
    );
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: SignUpFormStatus.loading));
    final result = await _authRepository.logInWithGoogle();
    emit(
      result.fold(
        (failure) => state.copyWith(
          errorCode: failure.code,
          status: SignUpFormStatus.failure,
        ),
        (_) => state.copyWith(status: SignUpFormStatus.success),
      ),
    );
  }
}
