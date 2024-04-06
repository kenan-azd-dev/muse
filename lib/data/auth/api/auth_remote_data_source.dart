import 'package:flutter/foundation.dart';

// 3rd Party Packages
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

// Project Files
import '../../../core/exceptions/exceptions.dart';
import '../../../core/models/models.dart';
import './auth_api.dart';

class AuthRemoteDataSource extends AuthApi {
  AuthRemoteDataSource({
    CacheClient? cache,
    fire_auth.FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? fire_auth.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _cache = cache ?? CacheClient(),
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final fire_auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final CacheClient _cache;
  final GoogleSignIn _googleSignIn;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Whether or not the current environment is web
  /// Should only be overridden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  ///Doc reference to a user
  DocumentReference _userRef(String uid) {
    return _firestore.collection('users').doc(uid);
  }

  /// Returns the current cached user.
  ///
  /// Defaults to [UserProfile.empty] if there is no cached user.
  @override
  UserProfile get currentUser {
    return _cache.read<UserProfile>(key: userCacheKey) ?? UserProfile.empty;
  }

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
      if (isWeb) {
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
  Future<void> logInWithUsernameAndPassword({
    required String username,
    required String password,
  }) async {
    final snap = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) {
      throw AuthException(code: 'user-not-found');
    }
    final userReference = snap.docs.first;

    final UserProfile userData = UserProfile.fromMap(userReference.data());

    final String email = userData.user!.email;

    logInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> logout() async => await _auth.signOut();

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required UserProfile userProfile,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      try {
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .set(userProfile.copyWith(uid: _auth.currentUser!.uid).toMap());
      } catch (_) {
        if (_auth.currentUser != null) {
          await _auth.currentUser!.delete();
        }
        rethrow;
      }
    } on fire_auth.FirebaseAuthException catch (e) {
      throw AuthException(code: e.code);
    } catch (_) {
      throw AuthException();
    }
  }

  /// Stream of [UserProfile] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [UserProfile.empty] if the user is not authenticated.
  @override
  Stream<UserProfile> get user {
    return _auth.authStateChanges().asyncMap((firebaseUser) async {
      final user = firebaseUser == null
          ? UserProfile.empty
          : await _userRef(firebaseUser.uid)
              .get()
              .then((doc) => UserProfile.fromMap(doc.data() as JsonMap));
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }
}
