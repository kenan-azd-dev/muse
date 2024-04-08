part of 'create_profile_cubit.dart';

enum CreateProfileFormStatus {
  initial,
  loading,
  success,
  failure,
}

final class CreateProfileState extends Equatable {
  const CreateProfileState({
    this.displayName = '',
    this.username = '',
    this.bio = '',
    this.status = CreateProfileFormStatus.initial,
    this.obscureText = true,
    this.errorCode,
    this.imageFile,
    this.isDisplayNameValid = false,
    this.isUsernameValid = false,
    required this.userProfile,
  });

  final String displayName;
  final String username;
  final String bio;
  final CreateProfileFormStatus status;
  final bool obscureText;
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
        obscureText,
        isDisplayNameValid,
        isUsernameValid,
        userProfile,
      ];

  CreateProfileState copyWith({
    String? displayName,
    String? username,
    String? bio,
    File? imageFile,
    CreateProfileFormStatus? status,
    bool? obscureText,
    String? errorCode,
    bool? isDisplayNameValid,
    bool? isUsernameValid,
    UserProfile? userProfile,
  }) {
    return CreateProfileState(
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      imageFile: imageFile ?? this.imageFile,
      status: status ?? this.status,
      obscureText: obscureText ?? this.obscureText,
      errorCode: errorCode,
      isDisplayNameValid: isDisplayNameValid ?? this.isDisplayNameValid,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
