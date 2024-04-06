import 'dart:io';

// 3rd Party Packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project Files
import '../../../../core/models/models.dart';
import '../../../../core/utils/form_validator.dart';
import '../../../../data/auth/repository/auth_repository.dart';

part 'create_profile_state.dart';

class CreateProfileCubit extends Cubit<CreateProfileState> {
  CreateProfileCubit(this._authRepository) : super(const CreateProfileState());

  final AuthRepository _authRepository;

  void updateDisplayName(String? displayName) {
    emit(
      state.copyWith(
        displayName: displayName,
        isDisplayNameValid: Validator.isDisplayNameValid(displayName ?? ''),
      ),
    );
  }

  void updateUsername(String? username) {
    emit(
      state.copyWith(
        username: username,
        isUsernameValid: Validator.isUsernameValid(username ?? ''),
      ),
    );
  }

  void updateBio(String? bio) {
    emit(
      state.copyWith(
        bio: bio,
      ),
    );
  }

  void updateImage(File imageFile) {
    emit(
      state.copyWith(
        imageFile: imageFile,
      ),
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    if (state.isUsernameValid == false || state.isDisplayNameValid == false) {
      print('==================');
      return;
    }
    emit(state.copyWith(status: CreateProfileFormStatus.loading));
    final userProfile = state
        .copyWith(
          userProfile: UserProfile(
            uid: '',
            isPrivate: false,
            isVerified: false,
            bio: state.bio,
            stats: UserStats.empty(),
            user: User(
              uid: '',
              displayName: state.displayName,
              username: state.username,
              email: email,
              urls: ImageUrlBundle.empty,
            ),
          ),
        )
        .userProfile;
    final result = await _authRepository.signUp(
      email: email,
      password: password,
      userProfile: userProfile,
    );
    emit(
      result.fold(
        (failure) => state.copyWith(
          errorCode: failure.code,
          status: CreateProfileFormStatus.failure,
        ),
        (_) => state.copyWith(status: CreateProfileFormStatus.success),
      ),
    );
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: CreateProfileFormStatus.loading));
    final result = await _authRepository.logInWithGoogle();
    emit(
      result.fold(
        (failure) => state.copyWith(
          errorCode: failure.code,
          status: CreateProfileFormStatus.failure,
        ),
        (_) => state.copyWith(status: CreateProfileFormStatus.success),
      ),
    );
  }
}
