// 3rd Party Packages
import 'package:fpdart/fpdart.dart';

// Project Files
import '../../../core/exceptions/exceptions.dart';
import '../../../core/failures/failures.dart';
import '../../../core/models/models.dart';
import '../api/auth_api.dart';

class AuthRepository {
  const AuthRepository({
    required AuthApi authApi,
  }) : _authApi = authApi;

  final AuthApi _authApi;

  UserProfile get currentUser => _authApi.currentUser;

  Future<Either<AuthFailure, void>> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _authApi.logInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(code: e.code));
    } catch (_) {
      return const Left(AuthFailure());
    }
  }

  Future<Either<AuthFailure, void>> logInWithGoogle() async {
    try {
      await _authApi.logInWithGoogle();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(code: e.code));
    } catch (_) {
      return const Left(AuthFailure());
    }
  }

  Future<Either<AuthFailure, void>> logInWithUsernameAndPassword({
    required String username,
    required String password,
  }) async {
    try {
      await _authApi.logInWithUsernameAndPassword(
        username: username,
        password: password,
      );
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(code: e.code));
    } catch (_) {
      return const Left(AuthFailure());
    }
  }

  Future<Either<AuthFailure, void>> logOut() async {
    try {
      _authApi.logout();
      return const Right(null);
    } catch (_) {
      return const Left(AuthFailure());
    }
  }

  Future<Either<AuthFailure, void>> signUp({
    required String email,
    required String password,
    required UserProfile userProfile,
  }) async {
    try {
      await _authApi.signUp(
        email: email,
        password: password,
        userProfile: userProfile,
      );
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(code: e.code));
    } catch (_) {
      return const Left(AuthFailure());
    }
  }

  Stream<UserProfile> get user => _authApi.user;
}
