import 'package:flutter/material.dart';

// Project Files
import '../../widgets/post_item/post_item.dart';
import './widgets/main_app_bar.dart';
import './widgets/stories_list.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10 + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const MainAppBar();
            } else if (index == 1) {
              return const StoriesList();
            } else {
              return const PostItem(
                userName: 'user_name',
                userProfilePicUrl:
                    'https://www.shutterstock.com/image-photo/business-woman-drawing-global-structure-260nw-1006041130.jpg',
                postImageUrl:
                    'https://www.shutterstock.com/image-photo/business-woman-drawing-global-structure-260nw-1006041130.jpg',
                numOfLikes: 100,
                numOfComments: 20,
                text:
                    'This is a loooooooooooooooooooooooooooooooooooooongooooooooooooooooooooooooooooooooooo caption',
              );
            }
          },
        ),
      ),
    );
  }
}
