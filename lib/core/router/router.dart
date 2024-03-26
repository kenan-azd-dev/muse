import 'package:flutter/material.dart';

// Project Files
import '../../ui/pages/edit_profile_page/edit_profile_page.dart';
import '../../ui/pages/feed_page/feed_page.dart';
import '../../ui/pages/post_page/post_page.dart';
import '../common/widgets/error_page.dart';

part 'routes.dart';

class Routing {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (_) => const FeedPage());
      case postPage:
        return MaterialPageRoute(
            builder: (_) => const PostPage(
                  userName: 'user_name',
                  userProfilePicUrl:
                      'https://www.shutterstock.com/image-photo/business-woman-drawing-global-structure-260nw-1006041130.jpg',
                  postImageUrl:
                      'https://www.shutterstock.com/image-photo/business-woman-drawing-global-structure-260nw-1006041130.jpg',
                  numOfLikes: 100,
                  numOfComments: 20,
                  text:
                      'This is a loooooooooooooooooooooooooooooooooooooongooooooooooooooooooooooooooooooooooo caption',
                ));
      case editProfilePage:
        return MaterialPageRoute(builder: (_) => const EditProfilePage());

      default:
        return MaterialPageRoute(builder: (_) => const ErrorPage());
    }
  }
}
