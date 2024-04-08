import 'dart:io';

import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as path; // Import path package for path operations

class ImageUtils {
  Future<List<File>> splitImage(File imageFile) async {
    final size = ImageSizeGetter.getSize(FileInput(imageFile));

    final directory = await getApplicationDocumentsDirectory();
    final fileName = DateTime.now().toIso8601String();

    final imagePaths = {
      'large': path.join(directory.path, '${fileName}_large.png'),
      'medium': path.join(directory.path, '${fileName}_medium.png'),
      'small': path.join(directory.path, '${fileName}_small.png'),
    };

    final resizedImages = await Future.wait(
      imagePaths.entries.map(
        (entry) => _resizeImage(
          file: imageFile,
          maxWidth: _calculateMaxWidth(entry.key),
          path: entry.value,
          size: size,
        ),
      ),
    );

    return resizedImages.toList();
  }

  Future<File> _resizeImage({
    required File file,
    required Size size,
    required int maxWidth,
    required String path,
  }) async {
    final image = img.decodeImage(file.readAsBytesSync())!;
    final imageBytes = img.encodeJpg(
      img.copyResize(image, width: _calculateWidth(size, maxWidth)),
    );
    return File(path)..writeAsBytesSync(imageBytes);
  }

  int _calculateWidth(Size size, int maxWidth) {
    final originalWidth = size.width;
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


// class ImageUtils {
//   Future<List<File>> splitImage(File imageFile) async {
//     final resizedImages = <File>[];

//     final size = ImageSizeGetter.getSize(FileInput(imageFile));

//     final directory = (await getApplicationDocumentsDirectory()).path;
//     String fileName = DateTime.now().toIso8601String();

//     final largePath = '$directory/${fileName}_large.png';
//     final mediumPath = '$directory/${fileName}_medium.png';
//     final smallPath = '$directory/${fileName}_small.png';

//     final large = await _resizeImage(
//       file: imageFile,
//       maxWidth: 1280,
//       path: largePath,
//       size: size,
//     );
//     resizedImages.add(large);

//     final medium = await _resizeImage(
//       file: imageFile,
//       maxWidth: 720,
//       path: mediumPath,
//       size: size,
//     );
//     resizedImages.add(medium);

//     final small = await _resizeImage(
//       file: imageFile,
//       maxWidth: 240,
//       path: smallPath,
//       size: size,
//     );
//     resizedImages.add(small);

//     return resizedImages;
//   }

//   Future<File> _resizeImage({
//     required File file,
//     required Size size,
//     required int maxWidth,
//     required String path,
//   }) async {
//     img.Image image = img.decodeImage(file.readAsBytesSync())!;

//     final originalWidth = size.width;
//     final originalHeight = size.height;

//     final newWidth = originalWidth > maxWidth ? maxWidth : originalWidth;
//     final newHeight = (originalHeight * newWidth) ~/ originalWidth;

//     img.Image resizedImage = img.copyResize(
//       image,
//       width: newWidth,
//       height: newHeight,
//     );

//     return File(path)..writeAsBytesSync(img.encodeJpg(resizedImage));
//   }
// }