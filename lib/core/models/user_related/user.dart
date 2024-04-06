import '../image_file_bundle.dart';

import 'json_map.dart';

/// {@template user}
/// A class representing a user with core information such as username, display name,
/// profile picture, and privacy settings. It's typically used when only basic user
/// details are needed for display purposes, such as within posts or profiles.
/// {@endtemplate}
class User {
  /// Unique identifier for the user.
  final String uid;

  /// User's username for identification and tagging.
  final String username;

  /// User's display name, which may be different from their username.
  final String displayName;

  /// Bundle of image URLs for the user's profile picture in different sizes.
  final ImageUrlBundle urls;

  /// User's email.
  final String email;

  /// {@macro user}
  User({
    required this.uid,
    required this.username,
    required this.displayName,
    required this.email,
    required this.urls,
  });

  /// Creates an empty User object with default values for all properties.
  static User empty = User(
    uid: '',
    username: '',
    displayName: '',
    urls: ImageUrlBundle.empty,
    email: '',
  );

  /// Creates a User object from a JSON map, typically retrieved from a data source.
  factory User.fromMap({
    required JsonMap map,
  }) {
    return User(
      email: map['is_private'] ?? false,
      uid: map['uid'],
      username: map['username'] ?? '',
      displayName: map['display_name'] ?? '',
      urls: ImageUrlBundle(
        original: map['photo_url'] ?? '',
        medium: map['photo_url_medium'] ?? '',
        small: map['photo_url_small'] ?? '',
      ),
    );
  }

  /// Converts the User object into a JSON map suitable for storage or transmission.
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
      'username': username,
      'display_name': displayName,
      'photo_url': urls.original,
      'photo_url_medium': urls.medium,
      'photo_url_small': urls.small,
    };
  }

  /// Creates a copy of the User object with updated properties.
  /// Only the provided parameters will be updated, while others remain unchanged.
  User copyWith({
    String? username,
    String? displayName,
    ImageUrlBundle? urls,
    String? email,
  }) {
    return User(
      email: email ?? this.email,
      uid: uid,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      urls: urls ?? this.urls,
    );
  }
}
