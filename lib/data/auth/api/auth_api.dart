import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/models/models.dart';

/// {@template auth_api}
/// The interface for an API which manages user authentication.
/// {@endtemplate}
@immutable
abstract class AuthApi {
  /// {@macro auth_api}
  const AuthApi();

  /// Provides a `Stream` of authentication status
  Stream<bool> get isAuthenticated;

  /// Returns the current user profile from the database.
  /// 
  /// Throws a [AuthException] on error.
  Future<UserProfile> get user;

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Returns a [AuthException] on error.
  Future<void> signUp({
    required String email,
    required String password,
    required UserProfile userProfile,
    File? profilePicFile,
  });

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [AuthException] on error.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Signs in with the provided [username] and [password].
  ///
  /// Throws a [AuthException] on error.
  Future<void> logInWithUsernameAndPassword({
    required String username,
    required String password,
  });

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [AuthException] on error.
  Future<void> logInWithGoogle();

  /// Signs out the current user which will emit
  /// `false` from the isAuthentication stream.
  ///
  /// Throws a [AuthException] on error.
  Future<void> logout();

  /// Updates the current user with the provided
  /// updated user profile and an optional image
  /// `File`.
  /// 
  /// Throws a [AuthException] on error.
  Future<void> setUser({
    required UserProfile userProfile,
    File? profilePicFile,
  });

  /// Deletes the current user.
  /// 
  /// Throws a [AuthException] on error.
  Future<void> deleteUser();
}
