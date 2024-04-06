part of 'user_bloc.dart';

enum UserStatus {
  authenticated,
  unauthenticated,
}

final class AppUserState extends Equatable {
  const AppUserState._({
    required this.status,
    this.user = const UserProfile(uid: ''),
  });

  const AppUserState.authenticated(UserProfile user)
      : this._(status: UserStatus.authenticated, user: user);

  const AppUserState.unauthenticated() : this._(status: UserStatus.unauthenticated);

  final UserStatus status;
  final UserProfile user;

  @override
  List<Object> get props => [status, user];
}