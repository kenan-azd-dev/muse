// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image/image.dart' as img;
import 'package:image_size_getter/image_size_getter.dart';
import 'package:muse/core/models/models.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// Represents an image uploaded to storage with different sizes (original, medium, small).
/// Used for managing image uploads.
class ImageFileBundle {
  /// Optional index for the image bundle.
  final int? index;

  final File original;

  /// The original, uncompressed image file. (Required)
  File? _large;

  /// The medium-sized image file, suitable for most displays. (Required)
  File? _medium;

  /// The small-sized image file, suitable for thumbnails or previews. (Required)
  File? _small;

  File? get large => _large;
  File? get medium => _medium;
  File? get small => _small;

  /// The aspect ratio of the image (width / height). Can be null if unknown.
  final double? aspectRatio;

  /// Creates a new instance of [ImageFileBundle].
  ///
  /// Throws an [ArgumentError] if the provided aspect ratio is invalid (less than or equal to 0 or infinite).
  ImageFileBundle({
    this.index,
    required this.original,
    this.aspectRatio,
  }) {
    if (aspectRatio != null) {
      if (aspectRatio! <= 0.0 || aspectRatio! >= double.infinity) {
        throw ArgumentError('aspectRatio must be between 0.0 and infinity');
      }
    }
  }

  // Use async/await consistently and avoid readAsBytesSync
  Future<void> splitImage() async {
    final bytes = await original.readAsBytes();
    final image = img.decodeImage(bytes);

    if (image == null) {
      throw Exception('Failed to decode image'); // Handle decoding error
    }

    final size = Size(image.width, image.height);
    final directory = await getApplicationDocumentsDirectory();
    final fileName = DateTime.now().toIso8601String();

    final imagePaths = {
      'large': path.join(directory.path, '${fileName}_large.jpg'),
      'medium': path.join(directory.path, '${fileName}_medium.jpg'),
      'small': path.join(directory.path, '${fileName}_small.jpg'),
    };

    final resizedImages = await Future.wait(
      imagePaths.entries.map((entry) => _resizeImage(
            image: image,
            maxWidth: _calculateMaxWidth(entry.key),
            path: entry.value,
            size: size,
          )),
    );

    _large = resizedImages[0];
    _medium = resizedImages[1];
    _small = resizedImages[2];
  }

  Future<File> _resizeImage({
    required img.Image image,
    required int maxWidth,
    required String path,
    required Size size,
  }) async {
    final resizedImage =
        img.copyResize(image, width: _calculateWidth(size, maxWidth));
    final imageBytes = img.encodeJpg(resizedImage);
    return File(path)..writeAsBytes(imageBytes);
  }

  int _calculateWidth(Size size, int maxWidth) {
    final originalWidth = size.width.toInt();
    return originalWidth > maxWidth ? maxWidth : originalWidth;
  }

  int _calculateMaxWidth(String sizeLabel) {
    switch (sizeLabel) {
      case 'large':
        return 1280;
      case 'medium':
        return 720;
      case 'small':
        return 240;
      default:
        throw ArgumentError('Invalid size label: $sizeLabel');
    }
  }
}

/// Represents an image retrieved from Firestore for display.
class ImageUrlBundle extends Equatable {
  /// Optional index for the image bundle.
  final int? index;

  /// The URL of the original, uncompressed image. (Required)
  final String large;

  /// The URL of the medium-sized image. (Required)
  final String medium;

  /// The URL of the small-sized image. (Required)
  final String small;

  /// The aspect ratio of the image (width / height).
  final double aspectRatio;

  /// Creates a new instance of [ImageUrlBundle].
  ///
  /// Uses an assertion to check for a valid aspect ratio (between 0.0 and infinity). Assertions are for development checks and won't trigger in release builds.
  const ImageUrlBundle({
    this.index,
    required this.large,
    required this.medium,
    required this.small,
    this.aspectRatio = 1.0,
  }) : assert(aspectRatio >= 0.0 && aspectRatio <= double.infinity,
            'aspectRatio must be between 0.0 and infinity');

  /// Creates an empty instance of [ImageUrlBundle] with all URLs set to empty strings.
  static ImageUrlBundle empty = const ImageUrlBundle(
    small: '',
    medium: '',
    large: '',
    aspectRatio: 1.0,
  );

  /// Creates an instance of [ImageUrlBundle] from a Firestore user document.
  ///
  /// Extracts image URLs from the document fields 'photo_url', 'photo_url_medium', and 'photo_url_small'.
  factory ImageUrlBundle.fromUserDoc(JsonMap doc) {
    return ImageUrlBundle(
      small: doc['photo_url_small'] ?? '',
      medium: doc['photo_url_medium'] ?? '',
      large: doc['photo_url'] ?? '',
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
      large: map['original'] ?? '',
      aspectRatio: (map['aspect_ratio'] ?? 1.0).toDouble(),
    );
  }

  ImageUrlBundle copyWith({
    int? index,
    String? large,
    String? medium,
    String? small,
    double? aspectRatio,
  }) {
    return ImageUrlBundle(
      index: index ?? this.index,
      large: large ?? this.large,
      medium: medium ?? this.medium,
      small: small ?? this.small,
      aspectRatio: aspectRatio ?? this.aspectRatio,
    );
  }

  @override
  List<Object?> get props {
    return [
      index,
      large,
      medium,
      small,
      aspectRatio,
    ];
  }
}
