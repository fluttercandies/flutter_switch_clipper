import 'dart:ui';

import 'package:flutter/material.dart';

///CircleClipper
class CircleClipper extends CustomClipper<Path> {
  CircleClipper({required this.animation}) : super(reclip: animation);

  ///animation
  final Animation<double> animation;

  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: (size.longestSide / 2 + 1) * animation.value,
        ),
      );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
