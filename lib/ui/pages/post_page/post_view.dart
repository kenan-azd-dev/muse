import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';

import '../../widgets/post_item/likeable_image_with_animation.dart';

// 3rd Party Packages

// Project Files

class PostView extends StatelessWidget {
  const PostView({
    super.key,
    required String userName,
    required String userProfilePicUrl,
    String? postImageUrl,
    required int numOfLikes,
    required int numOfComments,
    String? text,
  })  : _userName = userName,
        _userProfilePicUrl = userProfilePicUrl,
        _postImageUrl = postImageUrl,
        _numOfLikes = numOfLikes,
        _numOfComments = numOfComments,
        _text = text;

  final String _userName;
  final String _userProfilePicUrl;
  final String? _postImageUrl;
  final int _numOfLikes;
  final int _numOfComments;
  final String? _text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                        CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(_userProfilePicUrl),
                        ),
                        const SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "User Name",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "@$_userName",
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.more_vert_rounded),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const Gap(12),
                    if (_text != null)
                      const Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: ReadMoreText(
                          'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                          trimLines: 2,
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          lessStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    if (_postImageUrl != null) const Gap(12),
                    if (_postImageUrl != null)
                      Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: LikeableImageWithAnimation(
                              imageUrl: _postImageUrl),
                        ),
                      ),
                    if (_postImageUrl != null) const Gap(12),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        '11:14 PM, Mar 23/03',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite_border_rounded),
                          onPressed: () {},
                        ),
                        Text(_numOfLikes.toString()),
                        const Gap(12.0),
                        Icon(
                          CupertinoIcons.chat_bubble,
                          color: Colors.grey[400],
                        ),
                        const Gap(12.0),
                        Text(_numOfComments.toString()),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.bookmark_outline_rounded),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    bottom: 16.0, right: 16.0, left: 16.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 18,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 2),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: const CircleAvatar(),
                              ),
                              const Gap(12.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'User Name',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    '@user_name',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  const Gap(8.0),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 156,
                                    child: const ReadMoreText(
                                      'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                                      style: TextStyle(fontSize: 12.0),
                                      trimLines: 2,
                                      colorClickableText: Colors.pink,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'Show more',
                                      trimExpandedText: 'Show less',
                                      moreStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      lessStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_outline_rounded,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Gap(24.0),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 110),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 0),
                blurRadius: 10.0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 4),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: const CircleAvatar(),
              ),
              const Gap(8.0),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(hintText: 'Add a comment...'),
                  maxLines: null,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.paperPlane),
              )
            ],
          ),
        ),
      ),
    );
  }
}
