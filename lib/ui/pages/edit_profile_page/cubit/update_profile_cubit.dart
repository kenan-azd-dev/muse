import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/models/models.dart';
import '../../../../data/auth/repository/auth_repository.dart';


class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this._authRepository)
      : super(UpdateProfileState(userProfile: UserProfile.empty));

  final AuthRepository _authRepository;

  void updateDisplayName(String displayName) {
    emit(state.copyWith(displayName: displayName.trim()));
  }

  void updateUsername(String username) {
    emit(state.copyWith(username: username.trim().toLowerCase()));
  }

  void updateBio(String? bio) {
    emit(state.copyWith(bio: bio));
  }

  void updateImage(File imageFile) {
    emit(state.copyWith(imageFile: imageFile));
  }

  Future<void> updateProfile(UserProfile currentUserProfile) async {
    emit(state.copyWith(status: UpdateProfileFormStatus.loading));

    final updatedUserProfile = currentUserProfile.copyWith(
      displayName: state.displayName.isNotEmpty ? state.displayName : null,
      username: state.username.isNotEmpty ? state.username : null,
      bio: state.bio.isNotEmpty ? state.bio : null,
    );

    if (state.isUsernameValid && state.username.isNotEmpty) {
      final checkUserNameResult =
          await _authRepository.checkUserNameExistence(state.username);
      checkUserNameResult.fold(
        (failure) {
          emit(state.copyWith(
            errorCode: failure.code,
            status: UpdateProfileFormStatus.failure,
          ));
        },
        (_) => null,
      );
    }

    final result = await _authRepository.setUser(
      userProfile: updatedUserProfile,
      profilePicFile: state.imageFile,
    );

    emit(_handleSignUpResult(result));
  }

  UpdateProfileState _handleSignUpResult(Either<AuthFailure, void> result) {
    return result.fold(
      (failure) => state.copyWith(
        errorCode: failure.code,
        status: UpdateProfileFormStatus.failure,
      ),
      (_) => state.copyWith(
        status: UpdateProfileFormStatus.success,
        userProfile: state.userProfile,
      ),
    );
  }
}
