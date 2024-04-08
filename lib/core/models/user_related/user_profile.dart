// ignore_for_file: public_member_api_docs, sort_constructors_first
// 3rd Party Packages
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Project Files
import '../image_file_bundle.dart';
import './json_map.dart';
import './user.dart';
import './user_stats.dart';

/// {@template user_profile}
/// A class representing a user profile within the application.
/// {@endtemplate}
@immutable
class UserProfile extends Equatable {
  /// Unique identifier for the user.
  ///
  /// Cannot be empty.
  final String uid;

  /// Details about the user including username, display name, and profile picture.
  ///
  /// Cannot be empty.
  final User user;

  /// User statistics including post count, follower count, and following count.
  ///
  /// Cannot be empty.
  final UserStats stats;

  /// Optional bio text for the user profile.
  ///
  /// Defaults to an empty `String`.
  final String? bio;

  /// Flag indicating if the user is verified.
  ///
  /// Defaults to `false`.
  final bool? isVerified;

  /// Flag indicating if the user profile is private.
  ///
  /// Defaults to `false`.
  final bool? isPrivate;

  /// {@macro user_profile}
  const UserProfile({
    required this.uid,
    required this.user,
    required this.stats,
    this.bio = '',
    this.isVerified = false,
    this.isPrivate = false,
  });

  /// Empty user which might also represents an unauthenticated user.
  static UserProfile empty = UserProfile(
    uid: '',
    user: User.empty,
    stats: UserStats.empty,
  );

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserProfile.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserProfile.empty;

  /// Creates a UserProfile object from a JSON document retrieved from a data source.
  ///
  /// This factory constructor parses the document and populates the corresponding
  /// fields in the UserProfile object.
  factory UserProfile.fromMap(JsonMap doc) {
    final user = User(
      email: doc['user']['email'] ?? '',
      uid: doc['uid'],
      username: doc['user']['username'] ?? '',
      displayName: doc['user']['display_name'] ?? '',
      urls: ImageUrlBundle(
        large: doc['user']['photo_url'] ?? '',
        medium: doc['user']['photo_url_medium'] ?? '',
        small: doc['user']['photo_url_small'] ?? '',
      ),
    );

    final stats = UserStats(
      postCount: doc['post_count'] ?? 0,
      followerCount: doc['follower_count'] ?? 0,
      followingCount: doc['following_count'] ?? 0,
    );

    return UserProfile(
      uid: doc['uid'],
      user: user,
      stats: stats,
      bio: doc['bio'] ?? '',
      isVerified: doc['is_verified'] ?? false,
      isPrivate: doc['is_private'],
    );
  }

  /// Creates a copy of the UserProfile object with updated properties.
  ///
  /// Only the provided parameters will be updated, while others remain unchanged.
  UserProfile copyWith({
    String? uid,
    String? username,
    String? displayName,
    String? email,
    ImageUrlBundle? bundle,
    String? bio,
    bool? isPrivate,
    bool? isVerified,
    int? postCount,
    int? followerCount,
    int? followingCount,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      user: user.copyWith(
        uid: uid ?? user.uid,
        username: username ?? user.username,
        displayName: displayName ?? user.displayName,
        urls: bundle ?? user.urls,
        email: email ?? user.email,
      ),
      isVerified: isVerified ?? this.isVerified,
      isPrivate: isPrivate ?? this.isPrivate,
      bio: bio ?? this.bio,
      stats: stats.copyWith(
        postCount: postCount,
        followerCount: followerCount,
        followingCount: followingCount,
      ),
    );
  }

  /// Converts the UserProfile object to a JSON map suitable for storage or transmission.
  JsonMap toMap() {
    return {
      'uid': uid,
      'user': user.toMap(),
      'username': user.username,
      'user_stats': stats.toMap(),
      'is_verified': isVerified,
      'is_private': isPrivate,
      'bio': bio,
    };
  }

  @override
  List<Object?> get props {
    return [
      uid,
      user,
      stats,
      bio,
      isVerified,
      isPrivate,
    ];
  }
}
