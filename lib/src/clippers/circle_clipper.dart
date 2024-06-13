import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'animation_clipper.dart';

/// CircleClipper
class CircleClipper extends AnimationClip {
  CircleClipper();

  /// Size备份
  Size? _size;

  /// 对角线长度
  late double _diagonal;

  @override
  Path getClip(Size size, Animation<double> animation) {
    return Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: _getDiagonal(size) / 2 * animation.value,
        ),
      );
  }

  /// 计算对角线
  double _getDiagonal(Size size) {
    if (size != _size) {
      _size = size;
      _diagonal =
          math.sqrt(size.width * size.width + size.height * size.height);
    }

    return _diagonal;
  }
}
