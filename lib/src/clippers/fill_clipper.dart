import 'package:flutter/material.dart';
import 'package:flutter_switch_clipper/src/helper/fill_alignment.dart';

///填充裁切
class FillClipper extends CustomClipper<Path> {
  const FillClipper({
    required this.animation,
    this.fillAlignment = FillAlignment.left,
    this.fillOffset = 20,
  }) : super(reclip: animation);

  ///* 裁切起始方向
  ///* 默认 `FillAlignment.left`
  final FillAlignment fillAlignment;

  ///* 裁切弧度偏移量
  ///* 默认`20`
  final double fillOffset;

  ///动画对象
  final Animation<double> animation;

  @override
  Path getClip(Size size) {
    final double w = size.width;
    final double h = size.height;

    final Path path = Path();

    if (fillAlignment == FillAlignment.top) {
      path
        ..moveTo(0, -fillOffset)
        ..lineTo(w, -fillOffset)
        ..lineTo(w, h * animation.value - fillOffset * (1 - animation.value))
        ..quadraticBezierTo(w / 2, h * animation.value, 0,
            h * animation.value - fillOffset * (1 - animation.value))
        ..close();
    } else if (fillAlignment == FillAlignment.right) {
      path
        ..moveTo(w + fillOffset, 0)
        ..lineTo(w + fillOffset, h)
        ..lineTo((w + fillOffset) * (1 - animation.value), h)
        ..quadraticBezierTo(
          (w - (fillOffset - 1)) * (1 - animation.value),
          h / 2,
          (w + fillOffset) * (1 - animation.value),
          0,
        )
        ..close();
    } else if (fillAlignment == FillAlignment.bottom) {
      path
        ..moveTo(0, h + fillOffset)
        ..lineTo(w, h + fillOffset)
        ..lineTo(w, (h + fillOffset) * (1 - animation.value))
        ..quadraticBezierTo(
            w / 2,
            (h - (fillOffset - 1)) * (1 - animation.value),
            0,
            (h + fillOffset) * (1 - animation.value))
        ..close();
    } else {
      path
        ..moveTo(-fillOffset, 0)
        ..lineTo(-fillOffset, h)
        ..lineTo(w * animation.value - fillOffset * (1 - animation.value), h)
        ..quadraticBezierTo(
          (w + fillOffset - 1) * animation.value,
          h / 2,
          w * animation.value - fillOffset * (1 - animation.value),
          0,
        )
        ..close();
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
