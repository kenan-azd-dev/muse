import 'package:test/test.dart';
import 'package:muse/core/models/models.dart';

void main() {
  group('User', () {
    // Sample user data
    const String uid = 'test_uid';
    const String username = 'test_username';
    const String displayName = 'Test User';
    const String email = 'test@example.com';
    const ImageUrlBundle urls = ImageUrlBundle(
      large: 'https://example.com/profile_large.jpg',
      medium: 'https://example.com/profile_medium.jpg',
      small: 'https://example.com/profile_small.jpg',
    );

    test('creates a new instance with correct values', () {
      const user = User(
        uid: uid,
        username: username,
        displayName: displayName,
        email: email,
        urls: urls,
      );
      expect(user.uid, uid);
      expect(user.username, username);
      expect(user.displayName, displayName);
      expect(user.email, email);
      expect(user.urls, urls);
    });

    test('empty creates a User object with default values', () {
      final emptyUser = User.empty;
      expect(emptyUser.uid, '');
      expect(emptyUser.username, '');
      expect(emptyUser.displayName, '');
      expect(emptyUser.email, '');
      expect(emptyUser.urls, ImageUrlBundle.empty);
    });

    test('fromMap creates a User object from a JSON map', () {
      final map = {
        'email': email,
        'uid': uid,
        'username': username,
        'display_name': displayName,
        'photo_url': urls.large,
        'photo_url_medium': urls.medium,
        'photo_url_small': urls.small,
      };
      final userFromMap = User.fromMap(map: map);
      expect(userFromMap.uid, uid);
      expect(userFromMap.username, username);
      expect(userFromMap.displayName, displayName);
      expect(userFromMap.email, email);
      expect(userFromMap.urls, urls);
    });

    test('toMap converts to a JSON map with expected keys and values', () {
      const user = User(
        uid: uid,
        username: username,
        displayName: displayName,
        email: email,
        urls: urls,
      );
      final expectedMap = {
        'email': email,
        'uid': uid,
        'username': username,
        'display_name': displayName,
        'photo_url': urls.large,
        'photo_url_medium': urls.medium,
        'photo_url_small': urls.small,
      };
      expect(user.toMap(), expectedMap);
    });

    test('copyWith creates a new instance with updated properties', () {
      const user = User(
        uid: uid,
        username: username,
        displayName: displayName,
        email: email,
        urls: urls,
      );
      final updatedUser = user.copyWith(
        username: 'new_username',
        email: 'newemail@example.com',
      );
      expect(updatedUser.uid, uid);
      expect(updatedUser.username, 'new_username');
      expect(updatedUser.displayName, displayName);
      expect(updatedUser.email, 'newemail@example.com');
      expect(updatedUser.urls, urls);
      expect(updatedUser, isNot(same(user))); // Check for new instance
    });
  });
}
