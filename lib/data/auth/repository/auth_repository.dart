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

  Stream<UserProfile> get user => _authApi.user;

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

  Future<Either<AuthFailure, void>> deleteUser() async {
    try {
      await _authApi.deleteUser();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(code: e.code));
    } catch (_) {
      return const Left(AuthFailure());
    }
  }

  Future<Either<AuthFailure, void>> setUser({
    required UserProfile userProfile,
    File? profilePicFile,
  }) async {
    try {
      await _authApi.setUser(
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

  Future<Either<AuthFailure, void>> checkUserNameExistence(
      String username) async {
    try {
      await _authApi.checkUserNameExistence(username);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(code: e.code));
    } catch (_) {
      return const Left(AuthFailure());
    }
  }
}
