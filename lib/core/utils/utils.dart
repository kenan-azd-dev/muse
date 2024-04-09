import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  void editPic(ImageSource source, void Function(File) changePic) async {}
  static Future<dynamic> showPickerBottomSheet(
      BuildContext context, void Function(File) changePic) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.3,
                width: MediaQuery.of(context).size.width * 0.3,
                child: OutlinedButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    await picker
                        .pickImage(source: ImageSource.camera)
                        .then((pickedImage) {
                      if (pickedImage != null) {
                        changePic(File(pickedImage.path));
                      }
                    });
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_rounded),
                      Gap(8.0),
                      Text("Camera")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.3,
                width: MediaQuery.of(context).size.width * 0.3,
                child: OutlinedButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    await picker
                        .pickImage(source: ImageSource.gallery)
                        .then((pickedImage) {
                      if (pickedImage != null) {
                        changePic(File(pickedImage.path));
                      }
                    });
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_rounded),
                      Gap(8.0),
                      Text("Gallery")
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
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