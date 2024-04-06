part of 'user_bloc.dart';

sealed class AppUserEvent {
  const AppUserEvent();
}

final class UserLogoutRequested extends AppUserEvent {
  const UserLogoutRequested();
}

final class _AppUserChanged extends AppUserEvent {
  const _AppUserChanged(this.user);

  final UserProfile user;
}