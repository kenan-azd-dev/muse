import 'package:flutter_test/flutter_test.dart';
import 'package:muse/core/models/models.dart';

void main() {
  group('UserStats', () {
    test('creates a new instance with correct values', () {
      const stats = UserStats(
        postCount: 5,
        followerCount: 100,
        followingCount: 40,
      );
      expect(stats.postCount, 5);
      expect(stats.followerCount, 100);
      expect(stats.followingCount, 40);
    });

    test('empty creates a zero-value instance', () {
      final emptyStats = UserStats.empty;
      expect(emptyStats.postCount, 0);
      expect(emptyStats.followerCount, 0);
      expect(emptyStats.followingCount, 0);
    });

    test('fromMap creates an instance from a JSON map', () {
      final map = {
        'post_count': 12,
        'follower_count': 345,
        'following_count': 67,
      };
      final statsFromMap = UserStats.fromMap(map);
      expect(statsFromMap.postCount, 12);
      expect(statsFromMap.followerCount, 345);
      expect(statsFromMap.followingCount, 67);
    });

    test('fromMap creates empty instance from null map', () {
      final statsFromNullMap = UserStats.fromMap(null);
      expect(statsFromNullMap, UserStats.empty);
    });

    test('toMap converts to a JSON map', () {
      const stats =
          UserStats(postCount: 15, followerCount: 200, followingCount: 80);
      final expectedMap = {
        'post_count': 15,
        'follower_count': 200,
        'following_count': 80,
      };
      expect(stats.toMap(), expectedMap);
    });

    test('copyWith creates a new instance with updated values', () {
      const stats = UserStats(
        postCount: 5,
        followerCount: 10,
        followingCount: 5,
      );
      final updatedStats = stats.copyWith(followingCount: 8);
      expect(updatedStats.postCount, 5);
      expect(updatedStats.followerCount, 10);
      expect(updatedStats.followingCount, 8);
      expect(updatedStats, isNot(same(stats)));
    });

    test('incrementFollowerCount increases follower count', () {
      final stats = UserStats.empty.copyWith(followerCount: 10);
      final incrementedStats = stats.incrementFollowerCount();
      expect(incrementedStats.followerCount, 11);
      expect(incrementedStats, isNot(same(stats)));
    });

    test('decrementFollowerCount decreases follower count.', () {
      final stats = UserStats.empty.copyWith(followerCount: 10);
      final decrementedStats = stats.decrementFollowerCount();
      expect(decrementedStats.followerCount, 9);
      expect(decrementedStats, isNot(same(stats))); // Check for new instance
    });
  });
}
