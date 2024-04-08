import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muse/core/router/router.dart';
import 'package:muse/core/utils/form_validator.dart';

import 'cubit/create_profile_cubit.dart';

class CreateProfileView extends StatelessWidget with Validator {
  CreateProfileView({
    super.key,
    required String email,
    required String password,
  })  : _email = email,
        _password = password;

  final String _email;
  final String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a profile'),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<CreateProfileCubit, CreateProfileState>(
          listener: (context, state) {
            if (state.status == CreateProfileFormStatus.success) {
              Navigator.pushReplacementNamed(context, profileCompleted);
            } else if (state.status == CreateProfileFormStatus.failure) {}
          },
          builder: (context, state) {
            if (state.status == CreateProfileFormStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formKey,
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
                      child: BlocSelector<CreateProfileCubit,
                          CreateProfileState, File?>(
                        selector: (state) {
                          return state.imageFile;
                        },
                        builder: (_, state) {
                          return CircleAvatar(
                            radius: 50,
                            foregroundImage: (state != null
                                ? FileImage(state)
                                : const AssetImage(
                                    'assets/images/empty-user.jpg')) as ImageProvider,
                          );
                        },
                      ),
                    ),
                    TextButton(
                      child: const Text('Edit picture'),
                      onPressed: () {
                        _showPickerBottomSheet(
                            context,
                            (image) => context
                                .read<CreateProfileCubit>()
                                .updateImage(image));
                      },
                    ),
                    const Gap(8.0),
                    NameTextField(
                      onChanged: (value) => context
                          .read<CreateProfileCubit>()
                          .updateDisplayName(value),
                    ),
                    const Gap(12.0),
                    UsernameTextField(
                      onChanged: (value) => context
                          .read<CreateProfileCubit>()
                          .updateUsername(value),
                    ),
                    const Gap(12.0),
                    BioTextField(
                      onChanged: (value) =>
                          context.read<CreateProfileCubit>().updateBio(value),
                    ),
                    const Gap(12.0),
                    SizedBox(
                      height: 64,
                      width: double.maxFinite,
                      child: OutlinedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          context.read<CreateProfileCubit>().signUp(
                                email: _email,
                                password: _password,
                              );
                        },
                        child: const Text('Create profile'),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _editPic(ImageSource source, void Function(File) changePic) async {
    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: source).then((pickedImage) {
      if (pickedImage != null) {
        changePic(File(pickedImage.path));
      }
    });
  }

  Future<dynamic> _showPickerBottomSheet(
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
                  onPressed: () => _editPic(ImageSource.camera, changePic),
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
                  onPressed: () => _editPic(ImageSource.gallery, changePic),
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

class NameTextField extends StatelessWidget with Validator {
  const NameTextField({
    super.key,
    void Function(String)? onChanged,
  }) : _onChanged = onChanged;

  final void Function(String)? _onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 30,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        label: Text('Name'),
      ),
      validator: (value) => validateDisplayName(value),
      onChanged: _onChanged,
    );
  }
}

class UsernameTextField extends StatelessWidget with Validator {
  const UsernameTextField({
    super.key,
    void Function(String)? onChanged,
  }) : _onChanged = onChanged;

  final void Function(String)? _onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      maxLength: 30,
      decoration: const InputDecoration(
        label: Text('Username'),
      ),
      validator: (value) => validateUsername(value),
      onChanged: _onChanged,
    );
  }
}

class BioTextField extends StatelessWidget with Validator {
  const BioTextField({
    super.key,
    void Function(String)? onChanged,
  }) : _onChanged = onChanged;

  final void Function(String)? _onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 200,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        label: Text('Username'),
      ),
      maxLines: 3,
      onChanged: _onChanged,
    );
  }
}
