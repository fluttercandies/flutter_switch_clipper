import 'package:flutter/material.dart';
import 'package:flutter_switch_clipper/src/helper/clipper_enum.dart';

import 'animation_clipper.dart';

/// WaveClipper
/// 波浪裁剪
class WaveClipper extends AnimationClip {
  WaveClipper({
    this.waveHeight = 10,
    this.waveWidth = 100,
    this.waveSpeed = 2,
    this.waveAlignment = WaveAlignment.left,
  });

  /// 波浪高度
  final double waveHeight;

  /// 波浪宽度
  final double waveWidth;

  /// 波浪速度
  final int waveSpeed;

  /// 波浪朝向(流动方向)
  final WaveAlignment waveAlignment;

  @override
  Path getClip(Size size, Animation<double> animation) {
    final double w = size.width;
    final double h = size.height;
    final Path path = Path();

    //每组波浪的数量
    final int everyGroupWaveCount = (w / waveWidth).ceil();

    //波浪虚拟数量
    //2代表只准备两组循环利用
    final int waveCount = 2 * everyGroupWaveCount;

    path.moveTo(0, -waveHeight);
    for (int i = 0; i < waveCount; i++) {
      path.relativeQuadraticBezierTo(
          waveWidth / 2, -waveHeight * 2, waveWidth, 0);
      path.relativeQuadraticBezierTo(
          waveWidth / 2, waveHeight * 2, waveWidth, 0);
    }
    path.lineTo(waveWidth * waveCount * 2, h);
    path.lineTo(0, h);
    path.close();

    //波浪总数量
    final int totalCount = waveSpeed * everyGroupWaveCount;

    if (waveAlignment == WaveAlignment.right) {
      //波浪往右
      //波浪总宽度
      final double waveTotalWidth = totalCount * waveWidth;
      return path.shift(
        Offset(
          -waveTotalWidth * (1 - animation.value),
          (h + waveHeight * 2) * (1 - animation.value),
        ),
      );
    }

    return path.shift(
      Offset(
        -waveWidth * ((totalCount * animation.value) % 2),
        (h + waveHeight * 2) * (1 - animation.value),
      ),
    );
  }
}
