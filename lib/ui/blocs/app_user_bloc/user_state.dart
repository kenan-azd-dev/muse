part of 'user_bloc.dart';

enum UserStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
}

final class AppUserState extends Equatable {
  const AppUserState({
    this.status = UserStatus.initial,
    required this.user,
  });

  final UserStatus status;
  final UserProfile user;

  AppUserState copyWith({
  UserStatus? status,
  UserProfile? user,
  }) {
    return AppUserState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, user];
}
