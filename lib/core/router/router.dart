import 'package:flutter/material.dart';
import 'package:muse/core/router/arguments/sign_up_arguments.dart';

// Project Files
import '../../ui/pages/create_profile_page/create_profile_page.dart';
import '../../ui/pages/home_page/home_page.dart';
import '../../ui/pages/login_page/login_page.dart';
import '../../ui/pages/post_page/post_page.dart';
import '../../ui/pages/profile_completed/profile_completed_page.dart';
import '../../ui/pages/sign_up_page/sign_up_page.dart';
import '../../ui/pages/update_profile_page/update_profile_page.dart';
import '../common/widgets/error_page.dart';

part 'routes.dart';

class Routing {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signUpPage:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case createAccountPage:
        final args = settings.arguments;
        if (args is SignUpArguments) {
          return MaterialPageRoute(
            builder: (_) => CreateProfilePage(
              email: args.email,
              password: args.password,
            ),
          );
        } else {
          return MaterialPageRoute(builder: (_) => const ErrorPage());
        }
      case profileCompleted:
        return MaterialPageRoute(builder: (_) => const ProfileCompletedPage());
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
