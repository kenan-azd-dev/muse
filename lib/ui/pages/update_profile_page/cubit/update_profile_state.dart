part of 'update_profile_cubit.dart';

enum UpdateProfileFormStatus {
  initial,
  loading,
  success,
  failure,
}

final class UpdateProfileState extends Equatable {
  const UpdateProfileState({
    this.displayName = '',
    this.username = '',
    this.bio = '',
    this.status = UpdateProfileFormStatus.initial,
    this.errorCode,
    this.imageFile,
    this.isDisplayNameValid = false,
    this.isUsernameValid = false,
    required this.userProfile,
  });

  final String displayName;
  final String username;
  final String bio;
  final UpdateProfileFormStatus status;
  final String? errorCode;
  final File? imageFile;

  final bool isDisplayNameValid;
  final bool isUsernameValid;

  final UserProfile userProfile;

  @override
  List<Object?> get props => [
        displayName,
        username,
        bio,
        imageFile,
        status,
        errorCode,
        isDisplayNameValid,
        isUsernameValid,
        userProfile,
      ];

  UpdateProfileState copyWith({
    String? displayName,
    String? username,
    String? bio,
    File? imageFile,
    UpdateProfileFormStatus? status,
    String? errorCode,
    bool? isDisplayNameValid,
    bool? isUsernameValid,
    UserProfile? userProfile,
  }) {
    return UpdateProfileState(
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      imageFile: imageFile ?? this.imageFile,
      status: status ?? this.status,
      errorCode: errorCode,
      isDisplayNameValid: isDisplayNameValid ?? this.isDisplayNameValid,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
