import 'package:flutter/material.dart';

abstract class AnimationClip {
  const AnimationClip();

  Path getClip(Size size, Animation<double> animation);
}
