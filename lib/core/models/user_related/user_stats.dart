// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'json_map.dart';

/// {@template user_stats}
/// Represents statistics for a user on a social media platform or similar system.
/// Tracks the number of posts, followers, and following users.
/// {@endtemplate}
@immutable
class UserStats extends Equatable {
  /// {@macro user_stats}
  const UserStats({
    required this.postCount,
    required this.followerCount,
    required this.followingCount,
  });

  /// The total number of posts created by the user.
  final int postCount;

  /// The total number of users following the user.
  final int followerCount;

  /// The total number of users the user is following.
  final int followingCount;

  /// Creates an empty instance of [UserStats] with all counts set to zero.
  static UserStats empty =
      const UserStats(postCount: 0, followerCount: 0, followingCount: 0);

  /// Creates an instance of [UserStats] from a JSON map.
  ///
  /// Extracts post count, follower count, and following count from the map with keys 'post_count', 'follower_count', and 'following_count' respectively.
  /// If the map is null, returns an empty [UserStats] object.
  factory UserStats.fromMap(JsonMap? map) {
    if (map == null) {
      return UserStats.empty;
    }
    return UserStats(
      postCount: map['post_count'] ?? 0,
      followerCount: map['follower_count'] ?? 0,
      followingCount: map['following_count'] ?? 0,
    );
  }

  JsonMap toMap() {
    return {
      'post_count': postCount,
      'follower_count': followerCount,
      'following_count': followingCount,
    };
  }

  /// Creates a copy of the current [UserStats] object with optional modifications.
  ///
  /// Parameters allow updating specific counts while keeping others unchanged.
  UserStats copyWith({
    int? postCount,
    int? followerCount,
    int? followingCount,
  }) {
    return UserStats(
      postCount: postCount ?? this.postCount,
      followerCount: followerCount ?? this.followerCount,
      followingCount: followingCount ?? this.followingCount,
    );
  }

  /// Increments the follower count by 1.
  ///
  /// Returns a new instance of [UserStats] with the updated follower count.
  UserStats incrementFollowerCount() {
    return copyWith(followerCount: followerCount + 1);
  }

  /// Decrements the follower count by 1.
  ///
  /// Returns a new instance of [UserStats] with the updated follower count.
  /// (Consider adding logic to prevent negative follower count)
  UserStats decrementFollowerCount() {
    if (followerCount - 1 < 0) {
      return this;
    }
    return copyWith(followerCount: followerCount - 1);
  }

  @override
  String toString() {
    return 'number of posts: $postCount\nnumber of followers: $followerCount\nnumber of following: $followingCount';
  }

  @override
  List<Object> get props => [postCount, followerCount, followingCount];
}
