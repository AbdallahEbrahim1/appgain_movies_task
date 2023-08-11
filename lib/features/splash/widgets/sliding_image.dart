import 'package:flutter/material.dart';

class SlidingImage extends StatelessWidget {
  final Animation<Offset> slidingAnimation;

  const SlidingImage({Key? key, required this.slidingAnimation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: slidingAnimation,
          builder: (context, widget) {
            return SlideTransition(
              position: slidingAnimation,
              child: const FlutterLogo(size: 150),
            );
          }),
    );
  }
}
