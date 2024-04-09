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