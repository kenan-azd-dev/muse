import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 3rd Party Packages
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/utils/utils.dart';
import '../../blocs/app_user_bloc/user_bloc.dart';
import '../../widgets/text_fields/text_fields.dart';
import 'cubit/update_profile_cubit.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey _alertKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
              listener: (context, state) {
                if (state.status == UpdateProfileFormStatus.success) {
                  if (_alertKey.currentContext != null) {
                    Navigator.pop(context);
                  }
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                final authState = BlocProvider.of<AppUserBloc>(context).state;
                if (state.status == UpdateProfileFormStatus.loading ||
                    authState.status == UserStatus.loading) {
                  Future.delayed(
                    Duration.zero,
                    () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return PopScope(
                            key: _alertKey,
                            canPop: false,
                            child: Center(
                              child: LoadingAnimationWidget.waveDots(
                                color: Theme.of(context).colorScheme.onInverseSurface,
                                size: 50,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 4),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: (state.imageFile == null
                            ? CachedNetworkImageProvider(
                                authState.user.user.urls.small)
                            : authState.user.user.urls.small.isEmpty
                                ? const AssetImage(
                                    'assets/images/user-empty.png')
                                : FileImage(state.imageFile!)) as ImageProvider,
                      ),
                    ),
                    TextButton(
                      child: const Text('Edit picture'),
                      onPressed: () async => await Utils.showPickerBottomSheet(
                        context,
                        (image) => context
                            .read<UpdateProfileCubit>()
                            .updateImage(image),
                      ),
                    ),
                    const Gap(8.0),
                    NameTextField(
                      initialValue: authState.user.user.displayName,
                      onChanged: (value) => context
                          .read<UpdateProfileCubit>()
                          .updateDisplayName(value),
                    ),
                    const Gap(12.0),
                    UsernameTextField(
                      initialValue: authState.user.user.username,
                      onChanged: (value) => context
                          .read<UpdateProfileCubit>()
                          .updateUsername(value),
                    ),
                    const Gap(12.0),
                    BioTextField(
                        initialValue: authState.user.bio,
                        onChanged: (value) => context
                            .read<UpdateProfileCubit>()
                            .updateBio(value)),
                    const Gap(12.0),
                    SizedBox(
                      height: 64,
                      width: double.maxFinite,
                      child: OutlinedButton(
                        onPressed: state.status == UpdateProfileFormStatus.initial ? null : () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          context.read<UpdateProfileCubit>().updateProfile(
                              context.read<AppUserBloc>().state.user);
                        },
                        child: const Text('Save changes'),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
