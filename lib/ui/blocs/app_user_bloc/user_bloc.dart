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
    on<_UserProfileFetched>(_onGotUser);
    _authSubscription = _authRepository.isAuthenticated.listen(
      (isAuth) {
        if (!isAuth) {
          add(const _AuthChanged());
          _userSubscription?.cancel();
        } else {
          _userSubscription = _authRepository.user
              .listen((user) => add(_UserProfileFetched(user)));
        }
      },
    );
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<bool> _authSubscription;
  StreamSubscription<UserProfile>? _userSubscription;

  void _onAuthChanged(_AuthChanged event, Emitter<AppUserState> emit) {
    emit(state.copyWith(
      status: UserStatus.unauthenticated,
      user: UserProfile.empty,
    ));
  }

  void _onGotUser(_UserProfileFetched event, Emitter<AppUserState> emit) {
    emit(state.copyWith(
      user: event.userProfile,
      status: event.userProfile.isEmpty
          ? UserStatus.unauthenticated
          : UserStatus.authenticated,
    ));
  }

  void _onLogoutRequested(
      UserLogoutRequested event, Emitter<AppUserState> emit) async {
    final result = await _authRepository.logOut();
    result.fold(
      (_) => null,
      (_) => state.copyWith(status: UserStatus.unauthenticated),
    );
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    _authSubscription.cancel();
    return super.close();
  }
}
