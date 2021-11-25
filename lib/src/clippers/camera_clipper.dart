import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_switch_clipper/src/helper/matrix4_transform.dart';

/// CameraClipper
/// 快门裁剪
class CameraClipper extends CustomClipper<Path> {
  CameraClipper({
    required this.animation,
    this.lensAperture = 20,
    this.lensAngle = -120,
  }) : super(reclip: animation);

  /// animation
  final Animation<double> animation;

  /// 镜头孔径
  final double lensAperture;

  /// 镜头旋转角度
  final double lensAngle;

  /// Size备份
  Size? _size;

  /// 对角线长度
  late double _diagonal;

  @override
  Path getClip(Size size) {
    //基础数据
    final double w = size.width;
    final double h = size.height;
    final double r = _getDiagonal(size) / 2 + lensAperture;
    final Offset center = Offset(w / 2, h / 2);

    //准备叶片路径
    Path bladePath = Path();

    //起始点
    final Offset start =
        center.translate(-math.sqrt(3) / 2 * lensAperture, lensAperture / 2);
    bladePath.moveTo(start.dx, start.dy);

    //顶点
    final double b = math.sqrt(r * r + r - lensAperture * lensAperture);
    bladePath.lineTo(start.dx, start.dy - b);

    //画弧
    final double endX = r * (math.sqrt(3) / 2) + center.dx;
    final double endY = -r / 2 + center.dy;
    bladePath.arcToPoint(Offset(endX, endY), radius: Radius.circular(r));
    bladePath.close();

    //平移
    bladePath = bladePath.shift(Offset(0, -r * (1 - animation.value)));

    //准备联合路径
    Path path = bladePath;

    //循环联合路径
    for (int i = 1; i <= 5; i++) {
      final Matrix4 rM =
          Matrix4Transform().rotateDegrees(i * 60, origin: center).matrix4;
      path = Path.combine(
          PathOperation.union, path, bladePath.transform(rM.storage));
    }

    //镜头旋转
    final Matrix4 roate = Matrix4Transform()
        .rotateDegrees(lensAngle * animation.value, origin: center)
        .matrix4;
    return path.transform(roate.storage);
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

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
