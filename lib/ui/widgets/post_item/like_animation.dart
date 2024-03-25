import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;
  const LikeAnimation({
    super.key,
    required this.child,
    required this.isAnimating,
    this.duration = const Duration(milliseconds: 150),
    this.onEnd,
    this.smallLike = false,
  });

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with TickerProviderStateMixin {
  late AnimationController animationController1;
  late AnimationController animationController2;
  late Animation<double> scale1;
  late Animation<double> scale2;

  @override
  void initState() {
    super.initState();
    animationController1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
    );
    animationController2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
    );
    scale1 = Tween<double>(begin: 1, end: 1.2).animate(animationController1);
    scale2 = Tween<double>(begin: 0, end: 1).animate(animationController2);
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimating();
    }
  }

  startAnimating() async {
    if (widget.isAnimating && !widget.smallLike) {
      await animationController2.forward();
      await animationController1.forward();
      await animationController1.reverse();
      await Future.delayed(const Duration(milliseconds: 400));
      await animationController2.reverse();
      await Future.delayed(const Duration(milliseconds: 200));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
    if (widget.isAnimating && widget.smallLike) {
      await animationController1.forward();
      await animationController1.reverse();
      await Future.delayed(const Duration(milliseconds: 200));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    animationController1.dispose();
    animationController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.smallLike
        ? ScaleTransition(
            scale: scale1,
            child: widget.child,
          )
        : ScaleTransition(
            scale: scale2,
            child: ScaleTransition(
              scale: scale1,
              child: widget.child,
            ),
          );
  }
}
