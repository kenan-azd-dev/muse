part of 'user_bloc.dart';

sealed class AppUserEvent {
  const AppUserEvent();
}

final class UserLogoutRequested extends AppUserEvent {
  const UserLogoutRequested();
}

final class _AuthChanged extends AppUserEvent {
  const _AuthChanged();
}

final class _UserProfileFetched extends AppUserEvent {
  final UserProfile userProfile;
  const _UserProfileFetched(this.userProfile);
}
