import 'dart:async';

// 3rd Party Packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project Files
import '../../../core/models/models.dart';
import '../../../data/auth/repository/auth_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  AppUserBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(AppUserState(user: UserProfile.empty)) {
    on<_AuthChanged>(_onAuthChanged);
    on<UserLogoutRequested>(_onLogoutRequested);
    on<UserProfileFetched>(_onGotUser);
    _userSubscription = _authRepository.isAuthenticated.listen(
      (isAuth) {
        if (!isAuth) {
          add(const _AuthChanged());
        }
      },
    );
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<bool> _userSubscription;

  void _onAuthChanged(_AuthChanged event, Emitter<AppUserState> emit) {
    emit(state.copyWith(
      status: UserStatus.unauthenticated,
      user: UserProfile.empty,
    ));
  }

  void _onGotUser(UserProfileFetched event, Emitter<AppUserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    final result = await _authRepository.user;
    emit(
      result.fold(
        (failure) => state.copyWith(status: UserStatus.unauthenticated),
        (userProfile) => state.copyWith(
          status: UserStatus.authenticated,
          user: userProfile,
        ),
      ),
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
