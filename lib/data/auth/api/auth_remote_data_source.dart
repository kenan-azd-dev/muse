import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

// 3rd Party Packages
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

// Project Files
import '../../../core/exceptions/exceptions.dart';
import '../../../core/models/models.dart';
import '../../../core/utils/firebase_utils.dart';
import './auth_api.dart';

/// {@template auth_remote_data_source}
/// An implementation of the AuthApi that uses [FirebaseAuth]
/// [FirebaseFirestore] as a remote data source.
/// {@endtemplate}
@immutable
class AuthRemoteDataSource implements AuthApi {
  final fire_auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  /// {@macro auth_remote_data_source}
  const AuthRemoteDataSource({
    required fire_auth.FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;
  static const usersCollection = 'users';

  /// Doc reference to a user
  DocumentReference _userRef(String uid) {
    return _firestore.collection(usersCollection).doc(uid);
  }

  @override
  Stream<bool> get isAuthenticated =>
      _auth.authStateChanges().map((user) => user != null);

  @override
  Stream<UserProfile> get user =>
      _userRef(_auth.currentUser!.uid).snapshots().map((doc) {
        if (doc.data() == null || _auth.currentUser == null) {
          return UserProfile.empty;
        }
        return UserProfile.fromMap(doc.data() as JsonMap);
      });

  @override
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on fire_auth.FirebaseAuthException catch (e) {
      throw AuthException(code: e.code);
    } catch (_) {
      throw AuthException();
    }
  }

  @override
  Future<void> logInWithGoogle() async {
    try {
      late final fire_auth.AuthCredential credential;
      if (kIsWeb) {
        final googleProvider = fire_auth.GoogleAuthProvider();
        final userCredential = await _auth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = fire_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _auth.signInWithCredential(credential);
    } on fire_auth.FirebaseAuthException catch (e) {
      throw AuthException(code: e.code);
    } catch (_) {
      throw AuthException();
    }
  }

  @override
  Future<void> checkUserNameExistence(String username) async {
    final snap = await _firestore
        .collection(usersCollection)
        .where('username', isEqualTo: username)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) {
      throw AuthException(code: 'username-exist');
    }
  }

  @override
  Future<void> logInWithUsernameAndPassword({
    required String username,
    required String password,
  }) async {
    final snap = await _firestore
        .collection(usersCollection)
        .where('username', isEqualTo: username)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) {
      throw AuthException(code: 'user-not-found');
    }
    final userReference = snap.docs.first;

    final UserProfile userData = UserProfile.fromMap(userReference.data());

    final String email = userData.user.email;

    await logInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required UserProfile userProfile,
    File? profilePicFile,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await setUser(
        userProfile: userProfile,
        profilePicFile: profilePicFile,
        uid: userCredential.user!.uid,
      );
    } on fire_auth.FirebaseAuthException catch (e) {
      throw AuthException(code: e.code);
    } catch (err) {
      throw AuthException();
    }
  }

  @override
  Future<void> setUser({
    required UserProfile userProfile,
    File? profilePicFile,
    String? uid,
  }) async {
    try {
      final imageUrlBundle = await _uploadProfilePicture(profilePicFile);

      // Update user profile with potential image URLs
      final updatedProfile = userProfile.copyWith(
        bundle: imageUrlBundle,
      );
      String? userId;
      if (uid != null) {
        userId = uid;
      } else {
        userId = _auth.currentUser!.uid;
      }
      await _userRef(userId).set(updatedProfile.toMap());
    } on fire_auth.FirebaseAuthException catch (e) {
      throw AuthException(code: e.code);
    } catch (err) {
      throw AuthException();
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      // Delete user from Firebase Authentication
      await _auth.currentUser!.delete();
      // Delete user data from Firestore
      await _firestore.collection('users').doc(_auth.currentUser!.uid).delete();
    } on fire_auth.FirebaseAuthException catch (e) {
      throw AuthException(code: e.code);
    } catch (err) {
      throw AuthException();
    }
  }

  /// Helper method for profile picture upload logic
  Future<ImageUrlBundle?> _uploadProfilePicture(File? profilePicFile) async {
    if (profilePicFile == null) return null;

    final imageBundle = ImageFileBundle(original: profilePicFile);
    await imageBundle.splitImage();

    final largeUrl = await FirebaseUtils.storeFileToFirebase(
        'profilePicUrl/${_auth.currentUser!.uid}', imageBundle.large!);
    final smallUrl = await FirebaseUtils.storeFileToFirebase(
        'profilePicUrl/${_auth.currentUser!.uid}', imageBundle.small!);
    final mediumUrl = await FirebaseUtils.storeFileToFirebase(
        'profilePicUrl/${_auth.currentUser!.uid}', imageBundle.medium!);

    return ImageUrlBundle(
      large: largeUrl,
      medium: mediumUrl,
      small: smallUrl,
    );
  }

  @override
  Future<void> logout() async => await _auth.signOut();
}
