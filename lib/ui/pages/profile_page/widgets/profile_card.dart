import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/core.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '10',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Posts'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '379',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Followers'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '417',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Following'),
                ],
              ),
            ],
          ),
          const Gap(12.0),
          const Text(
            '@kenan_azd',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Gap(8.0),
          const ReadMoreText(
            'This is a bio.',
            trimLines: 2,
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, editProfilePage),
                  child: const Text('Edit Profile'),
                ),
              ),
              const Gap(8.0),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Share Profile'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
