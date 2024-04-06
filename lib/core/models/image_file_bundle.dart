import 'dart:io';
// for aspectRatio validation

/// Represents an image uploaded to storage with different sizes (original, medium, small).
/// Used for managing image uploads.
class ImageFileBundle {
  /// Optional index for the image bundle.
  final int? index;

  /// The original, uncompressed image file. (Required)
  final File original;

  /// The medium-sized image file, suitable for most displays. (Required)
  final File medium;

  /// The small-sized image file, suitable for thumbnails or previews. (Required)
  final File small;

  /// The aspect ratio of the image (width / height). Can be null if unknown.
  final double? aspectRatio;

  /// Creates a new instance of [ImageFileBundle].
  ///
  /// Throws an [ArgumentError] if the provided aspect ratio is invalid (less than or equal to 0 or infinite).
  ImageFileBundle({
    this.index,
    required this.original,
    required this.medium,
    required this.small,
    this.aspectRatio,
  }) {
    if (aspectRatio != null) {
      if (aspectRatio! <= 0.0 || aspectRatio! >= double.infinity) {
        throw ArgumentError('aspectRatio must be between 0.0 and infinity');
      }
    }
  }
}

/// Represents an image retrieved from Firestore for display.
class ImageUrlBundle {
  /// Optional index for the image bundle.
  final int? index;

  /// The URL of the original, uncompressed image. (Required)
  final String original;

  /// The URL of the medium-sized image. (Required)
  final String medium;

  /// The URL of the small-sized image. (Required)
  final String small;

  /// The aspect ratio of the image (width / height).
  final double aspectRatio;

  /// Creates a new instance of [ImageUrlBundle].
  ///
  /// Uses an assertion to check for a valid aspect ratio (between 0.0 and infinity). Assertions are for development checks and won't trigger in release builds.
  ImageUrlBundle({
    this.index,
    required this.original,
    required this.medium,
    required this.small,
    this.aspectRatio = 1.0,
  }) : assert(aspectRatio >= 0.0 && aspectRatio <= double.infinity,
            'aspectRatio must be between 0.0 and infinity');

  /// Creates an empty instance of [ImageUrlBundle] with all URLs set to empty strings.
  static ImageUrlBundle empty = ImageUrlBundle(
    small: '',
    medium: '',
    original: '',
    aspectRatio: 1.0,
  );

  /// Creates an instance of [ImageUrlBundle] from a Firestore user document.
  ///
  /// Extracts image URLs from the document fields 'photo_url', 'photo_url_medium', and 'photo_url_small'.
  factory ImageUrlBundle.fromUserDoc(Map<String, dynamic> doc) {
    return ImageUrlBundle(
      small: doc['photo_url_small'] ?? '',
      medium: doc['photo_url_medium'] ?? '',
      original: doc['photo_url'] ?? '',
    );
  }

  /// Creates an instance of [ImageUrlBundle] from a map.
  ///
  /// Extracts image URLs and aspect ratio from the map keys 'small', 'medium', 'original', and 'aspect_ratio' (optional).
  factory ImageUrlBundle.fromMap(int index, Map map) {
    return ImageUrlBundle(
      index: index,
      small: map['small'] ?? '',
      medium: map['medium'] ?? '',
      original: map['original'] ?? '',
      aspectRatio: (map['aspect_ratio'] ?? 1.0).toDouble(),
    );
  }
}
