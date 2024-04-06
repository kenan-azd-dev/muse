import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/models/models.dart';
import '../../../data/auth/repository/auth_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  AppUserBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(
          authRepository.currentUser.isNotEmpty
              ? AppUserState.authenticated(authRepository.currentUser)
              : const AppUserState.unauthenticated(),
        ) {
    on<_AppUserChanged>(_onUserChanged);
    on<UserLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authRepository.user.listen(
      (user) => add(_AppUserChanged(user)),
    );
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<UserProfile> _userSubscription;

  void _onUserChanged(_AppUserChanged event, Emitter<AppUserState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppUserState.authenticated(event.user)
          : const AppUserState.unauthenticated(),
    );
  }

  void _onLogoutRequested(
      UserLogoutRequested event, Emitter<AppUserState> emit) {
    unawaited(_authRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
