import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_switch_clipper/src/helper/fill_alignment.dart';

///ShutterClipper
class ShutterClipper extends CustomClipper<Path> {
  ShutterClipper({
    required this.animation,
    this.activeAlignment = FillAlignment.top,
    this.fragment = 6,
  }) : super(reclip: animation);

  ///animation
  final Animation<double> animation;

  ///朝向
  final FillAlignment activeAlignment;

  ///叶片数量
  final int fragment;

  @override
  Path getClip(Size size) {
    ///叶片尺寸
    final double fragmentSize = _handleFragmentSize(size);

    final Path path = Path();

    for (int i = 0; i < fragment; i++) {
      double left = 0;
      double top = fragmentSize * i;
      double width = size.width;
      double height = fragmentSize * animation.value;

      if (activeAlignment == FillAlignment.left) {
        left = fragmentSize * i;
        top = 0;
        width = fragmentSize * animation.value;
        height = size.height;
      } else if (activeAlignment == FillAlignment.bottom) {
        left = 0;
        top = fragmentSize * (i + 1 - animation.value);
        width = size.width;
        height = fragmentSize * animation.value;
      } else if (activeAlignment == FillAlignment.right) {
        left = fragmentSize * (i + 1 - animation.value);
        top = 0;
        width = fragmentSize * animation.value;
        height = size.height;
      }

      path.addRect(Rect.fromLTWH(left, top, width, height));
    }

    return path;
  }

  ///处理叶片尺寸
  double _handleFragmentSize(Size size) {
    if (activeAlignment == FillAlignment.top ||
        activeAlignment == FillAlignment.bottom) {
      return size.height / fragment;
    }

    return size.width / fragment;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
