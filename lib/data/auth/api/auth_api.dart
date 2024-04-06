import '../../../core/models/models.dart';

/// {@template auth_api}
/// The interface for an API which manages user authentication.
/// {@endtemplate}
abstract class AuthApi {

  /// {@macro auth_api}
  const AuthApi();

  /// Stream of [UserProfile] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [UserProfile.empty] if the user is not authenticated.
  Stream<UserProfile> get user;

  /// Returns the current cached user.
  /// 
  /// Defaults to [UserProfile.empty] if there is no cached user.
  UserProfile get currentUser;

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Returns a [SignUpWithEmailAndPasswordFailure] on error.
  Future<void> signUp({
    required String email,
    required String password,
    required UserProfile userProfile,
  });

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] on error.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Signs in with the provided [username] and [password].
  ///
  /// Throws a [LogInWithUsernameAndPasswordFailure] on error.
  Future<void> logInWithUsernameAndPassword({
    required String username,
    required String password,
  });

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] on error.
  Future<void> logInWithGoogle();

  /// Signs out the current user which will emit
  /// [UserProfile.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] on error.
  Future<void> logout();
}
