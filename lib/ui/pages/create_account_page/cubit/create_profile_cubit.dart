import 'dart:io';

// 3rd Party Packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

// Project Files
import '../../../../core/failures/failures.dart';
import '../../../../core/models/models.dart';
import '../../../../core/utils/form_validator.dart';
import '../../../../data/auth/repository/auth_repository.dart';

part 'create_profile_state.dart';

class CreateProfileCubit extends Cubit<CreateProfileState> {
  CreateProfileCubit(this._authRepository)
      : super(CreateProfileState(userProfile: UserProfile.empty));

  final AuthRepository _authRepository;

  void updateDisplayName(String displayName) {
    final isDisplayNameValid = Validator.isDisplayNameValid(displayName);
    if (state.displayName != displayName || state.isDisplayNameValid != isDisplayNameValid) {
      emit(
        state.copyWith(
          displayName: displayName.trim(),
          isDisplayNameValid: isDisplayNameValid,
        ),
      );
    }
  }

  void updateUsername(String username) {
    final isUsernameValid = Validator.isUsernameValid(username);
    if (state.username != username || state.isUsernameValid != isUsernameValid) {
      emit(
        state.copyWith(
          username: username.trim().toLowerCase(),
          isUsernameValid: isUsernameValid,
        ),
      );
    }
  }

  void updateBio(String? bio) {
    if (state.bio != bio) {
      emit(
        state.copyWith(
          bio: bio,
        ),
      );
    }
  }

  void updateImage(File imageFile) {
    if (state.imageFile?.path != imageFile.path) {
      emit(
        state.copyWith(
          imageFile: imageFile,
        ),
      );
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    if (!state.isUsernameValid || !state.isDisplayNameValid) {
      return;
    }
    emit(state.copyWith(status: CreateProfileFormStatus.loading));
    
    final userProfile = UserProfile(
      uid: '',
      isPrivate: false,
      isVerified: false,
      bio: state.bio,
      stats: UserStats.empty,
      user: User(
        uid: '',
        displayName: state.displayName,
        username: state.username,
        email: email,
        urls: ImageUrlBundle.empty,
      ),
    );

    final result = await _authRepository.signUp(
      email: email.trim().toLowerCase(),
      password: password.trim(),
      userProfile: userProfile,
      profilePicFile: state.imageFile,
    );

    emit(_handleSignUpResult(result));
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: CreateProfileFormStatus.loading));
    final result = await _authRepository.logInWithGoogle();
    emit(_handleSignUpResult(result));
  }

  CreateProfileState _handleSignUpResult(Either<AuthFailure, void> result) {
    return result.fold(
      (failure) => state.copyWith(
        errorCode: failure.code,
        status: CreateProfileFormStatus.failure,
      ),
      (_) => state.copyWith(status: CreateProfileFormStatus.success),
    );
  }
}
