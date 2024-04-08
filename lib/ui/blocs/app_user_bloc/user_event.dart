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

final class UserProfileFetched extends AppUserEvent {
  const UserProfileFetched();
}
