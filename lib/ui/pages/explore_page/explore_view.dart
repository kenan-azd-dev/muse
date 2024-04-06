import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';

// Project Files
import '../../../core/router/router.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  int _index = 0;
  String _image =
      'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    tabs: <Widget>[
                      Tab(
                        text: 'Explore',
                      ),
                      Tab(
                        text: 'Reels',
                      ),
                      Tab(
                        icon: Icon(Icons.search_rounded),
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
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    postPage,
                                  ),
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
                        PageView.builder(
                          itemCount: 20,
                          pageSnapping: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 83),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Column(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                              Icons.favorite_outline_rounded),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                              CupertinoIcons.chat_bubble),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                              Icons.bookmark_outline_rounded),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                              Icons.more_vert_rounded),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 18.0,
                                    left: 18.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const CircleAvatar(),
                                            const Gap(8.0),
                                            const Text('User Name'),
                                            const Gap(8.0),
                                            OutlinedButton(
                                              onPressed: () {},
                                              child: const Text('Follow'),
                                            ),
                                          ],
                                        ),
                                        const Gap(8.0),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width - 60,
                                          child: const ReadMoreText(
                                            'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                                            trimLines: 1,
                                            colorClickableText: Colors.pink,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: 'Show more',
                                            trimExpandedText: 'Show less',
                                            moreStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                            lessStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const Text('data'),
                      ],
                    ),
                  ),
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
