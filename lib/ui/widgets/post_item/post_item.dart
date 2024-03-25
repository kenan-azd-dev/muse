import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';

// Project Files
import 'package:muse/ui/widgets/post_item/likeable_image_with_animation.dart';

class PostItem extends StatelessWidget {
  const PostItem({
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
    return Container(
      margin: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
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
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(_userProfilePicUrl),
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
                moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          if (_postImageUrl != null) const Gap(12),
          if (_postImageUrl != null)
            Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: LikeableImageWithAnimation(imageUrl: _postImageUrl),
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
              IconButton(
                icon: const Icon(CupertinoIcons.chat_bubble),
                onPressed: () {},
              ),
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
    );
  }
}
