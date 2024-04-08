import 'dart:io';

// 3rd Party Packages
import 'package:fpdart/fpdart.dart';

// Project Files
import '../../../core/exceptions/exceptions.dart';
import '../../../core/failures/failures.dart';
import '../../../core/models/models.dart';
import '../api/auth_api.dart';

/// {@template auth_repository}
/// A repository that handles authentication related requests.
/// {@endtemplate}
class AuthRepository {
  /// {@macro auth_repository}
  const AuthRepository({
    required AuthApi authApi,
  }) : _authApi = authApi;

  final AuthApi _authApi;

  Stream<bool> get isAuthenticated => _authApi.isAuthenticated;

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
    File? profilePicFile,
  }) async {
    try {
      await _authApi.signUp(
        email: email,
        password: password,
        userProfile: userProfile,
        profilePicFile: profilePicFile,
      );
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(code: e.code));
    } catch (_) {
      return const Left(AuthFailure());
    }
  }

  Future<Either<AuthFailure, UserProfile>> get user async {
    try {
      return Right(await _authApi.user);
    } catch (err) {
      return const Left(AuthFailure());
    }
  }

  Future<Either<AuthFailure, void>> logout() async {
    try {
      await _authApi.logout();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(code: e.code));
    } catch (_) {
      return const Left(AuthFailure());
    }
  }
}
