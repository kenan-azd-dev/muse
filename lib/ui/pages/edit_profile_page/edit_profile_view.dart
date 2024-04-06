import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  void _editPic(ImageSource source) {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: source);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 4),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 50,
                ),
              ),
              TextButton(
                child: const Text('Edit picture'),
                onPressed: () {
                  _showPickerBottomSheet(context);
                },
              ),
              const Gap(8.0),
              const TextField(
                decoration: InputDecoration(
                  label: Text('Name'),
                ),
              ),
              const Gap(12.0),
              const TextField(
                decoration: InputDecoration(
                  label: Text('Username'),
                ),
              ),
              const Gap(12.0),
              const TextField(
                decoration: InputDecoration(
                  label: Text('Bio'),
                ),
              ),
              const Gap(12.0),
              SizedBox(
                height: 64,
                width: double.maxFinite,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Save changes'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showPickerBottomSheet(BuildContext context) {
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
                  onPressed: () => _editPic(ImageSource.camera),
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
                  onPressed: () => _editPic(ImageSource.gallery),
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
