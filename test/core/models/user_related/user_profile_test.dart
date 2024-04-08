import 'package:test/test.dart';

import 'package:muse/core/models/models.dart';

void main() {
  group('UserProfile', () {
    // Sample user profile data
    const String uid = 'test_uid';
    final User user = User.empty.copyWith(uid: uid);
    final UserStats stats = UserStats.empty;
    const String bio = 'This is a test bio';
    const bool isVerified = true;
    const bool isPrivate = false;

    final UserProfile baseProfile = UserProfile(
      uid: uid,
      user: user,
      stats: stats,
      bio: bio,
      isVerified: isVerified,
      isPrivate: isPrivate,
    );

    test('creates a new user profile with required arguments', () {
      final user = User.empty;
      final stats = UserStats.empty;
      final profile = UserProfile(
        uid: 'test-uid',
        user: user,
        stats: stats,
      );

      expect(profile.uid, 'test-uid');
      expect(profile.user, user);
      expect(profile.stats, stats);
      expect(profile.bio, '');
      expect(profile.isVerified, false);
      expect(profile.isPrivate, false);
    });

    test('empty user profile has empty properties', () {
      final profile = UserProfile.empty;

      expect(profile.isEmpty, true);
      expect(profile.isNotEmpty, false);
      expect(profile.uid, '');
      expect(profile.user, User.empty);
      expect(profile.stats, UserStats.empty);
    });

    test('creates a user profile from a valid JSON map', () {
      final map = {
        'uid': 'test-uid',
        'email': 'test@example.com',
        'user': {
          'username': 'test_user',
          'display_name': 'Test User',
          'photo_url': 'https://example.com/profile.jpg',
        },
        'post_count': 10,
        'follower_count': 50,
        'following_count': 20,
        'bio': 'This is a test bio',
        'is_verified': true,
        'is_private': true,
      };

      final profile = UserProfile.fromMap(map);

      expect(profile.uid, 'test-uid');
      expect(profile.user.username, 'test_user');
      expect(profile.user.displayName, 'Test User');
      expect(profile.stats.postCount, 10);
      expect(profile.bio, 'This is a test bio');
      expect(profile.isVerified, true);
      expect(profile.isPrivate, true);
    });

    test('copyWith - updates only provided properties', () {
      final updatedProfile = baseProfile.copyWith(
        bio: 'Updated bio',
        isPrivate: true,
      );

      expect(updatedProfile.uid, baseProfile.uid);
      expect(updatedProfile.user, baseProfile.user);
      expect(updatedProfile.stats, baseProfile.stats);
      expect(updatedProfile.bio, 'Updated bio');
      expect(updatedProfile.isVerified, isVerified);
      expect(updatedProfile.isPrivate, true);
    });

    test('copyWith - handles null arguments', () {
      final updatedProfile = baseProfile.copyWith();

      expect(updatedProfile.uid, baseProfile.uid);
      expect(updatedProfile.user, baseProfile.user);
      expect(updatedProfile.stats, baseProfile.stats);
      expect(updatedProfile.bio, bio);
      expect(updatedProfile.isVerified, isVerified);
      expect(updatedProfile.isPrivate, isPrivate);
    });

    test('toMap - converts object to a JSON map', () {
      final expectedMap = {
        'uid': uid,
        'user': user.toMap(),
        'user_stats': stats.toMap(),
        'is_verified': isVerified,
        'is_private': isPrivate,
        'bio': bio,
      };

      expect(baseProfile.toMap(), expectedMap);
    });
  });
}
