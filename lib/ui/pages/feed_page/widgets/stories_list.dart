import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:gap/gap.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Project Files

class StoriesList extends StatelessWidget {
  const StoriesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.13,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: index == 0
                ? const EdgeInsets.only(left: 18, right: 10)
                : const EdgeInsets.only(right: 10),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(42),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.orange,
                            Colors.purple,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(42),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    index == 0
                        ? SizedBox(
                            //margin: const EdgeInsets.only(left: 18, right: 10),
                            height: 70,
                            width: 70,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                Material(
                                  elevation: 4.0,
                                  shape: const CircleBorder(),
                                  clipBehavior: Clip.antiAlias,
                                  color: Colors.transparent,
                                  child: Ink.image(
                                      image: const CachedNetworkImageProvider(
                                          'https://www.shutterstock.com/image-photo/business-woman-drawing-global-structure-260nw-1006041130.jpg'),
                                      fit: BoxFit.cover,
                                      width: 70.0,
                                      height: 70.0,
                                      child: InkWell(
                                        onTap: () {},
                                      )),
                                ),
                                Positioned(
                                  bottom: -5,
                                  right: -5,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(42),
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(42),
                                      onTap: () {},
                                      child: const Icon(
                                        CupertinoIcons.add_circled_solid,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Material(
                            elevation: 6.0,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.transparent,
                            child: Ink.image(
                              image: const NetworkImage(
                                  'https://www.shutterstock.com/image-photo/business-woman-drawing-global-structure-260nw-1006041130.jpg'),
                              fit: BoxFit.cover,
                              width: 70.0,
                              height: 70.0,
                              child: InkWell(
                                onTap: () {},
                              ),
                            ),
                          ),
                  ],
                ),
                const Gap(4.0),
                Text(
                  index == 0 ? 'Your Story' : 'User Name',
                  style: const TextStyle(fontSize: 10.0),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
