import 'package:flutter/cupertino.dart';

// 3rd Party Packages

// Project Files
import './post_view.dart';

class PostPage extends StatelessWidget {
  const PostPage({
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
    return PostView(
      userName: _userName,
      userProfilePicUrl: _userProfilePicUrl,
      postImageUrl: _postImageUrl,
      numOfLikes: _numOfLikes,
      numOfComments: _numOfComments,
      text: _text,
    );
  }
}
