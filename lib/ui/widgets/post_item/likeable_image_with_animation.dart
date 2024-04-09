import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// Project Files
import './like_animation.dart';

class LikeableImageWithAnimation extends StatefulWidget {
  const LikeableImageWithAnimation({
    super.key,
    required String imageUrl,
  }) : _imageUrl = imageUrl;

  final String _imageUrl;

  @override
  State<LikeableImageWithAnimation> createState() =>
      _LikeableImageWithAnimationState();
}

class _LikeableImageWithAnimationState
    extends State<LikeableImageWithAnimation> {
  bool isAnimating = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          isAnimating = true;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: widget._imageUrl,
              errorWidget: (context, url, error) {
                return const Center(
                  child: Text('An error occurred.'),
                );
              },
              placeholder: (context, url) {
                return Center(
                  child: LoadingAnimationWidget.waveDots(
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 30,
                  ),
                );
              },
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: isAnimating ? 1 : 0,
            child: LikeAnimation(
              isAnimating: isAnimating,
              child: Icon(
                Icons.favorite,
                size: 120,
                color: Colors.white.withOpacity(0.9),
                shadows: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 40.0,
                  ),
                ],
              ),
              onEnd: () {
                setState(() {
                  isAnimating = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
