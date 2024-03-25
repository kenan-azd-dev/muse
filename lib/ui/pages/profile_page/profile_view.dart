import 'dart:ui';

import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';

// Project Files
import '../../widgets/post_item/post_item.dart';
import './widgets/profile_card.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int _index = 0;
  String _image =
      'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Kenan AZD',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_outline_rounded),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container();
                    },
                  );
                },
                icon: const Icon(Icons.menu_rounded),
              ),
            ],
          ),
          body: SafeArea(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const ProfileCard(),
                  const TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.dashboard_rounded)),
                      Tab(icon: Icon(Icons.library_books_rounded)),
                      Tab(
                        icon: Icon(Icons.person_pin_rounded),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemCount: 14,
                          itemBuilder: (context, index) {
                            return Material(
                              child: GestureDetector(
                                onLongPress: () {
                                  setState(() {
                                    _index = 1;
                                  });
                                },
                                onLongPressEnd: (details) {
                                  setState(() {
                                    _index = 0;
                                  });
                                },
                                child: InkWell(
                                  onTap: () {
                                    print('object');
                                  },
                                  child: Ink.image(
                                    fit: BoxFit.cover,
                                    image: const CachedNetworkImageProvider(
                                      'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return const PostItem(
                              userName: 'kenan_azd',
                              userProfilePicUrl:
                                  'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',
                              numOfLikes: 10,
                              numOfComments: 2,
                              text: 'This is a test',
                            );
                          },
                        ),
                        const Icon(Icons.directions_transit),
                      ],
                    ),
                  ),
                  const Gap(83),
                ],
              ),
            ),
          ),
        ),
        if (_index != 0)
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 400,
                  maxWidth: 400,
                ),
                child: Image.network(
                  _image,
                ),
              ),
            ),
          )
      ],
    );
  }
}
