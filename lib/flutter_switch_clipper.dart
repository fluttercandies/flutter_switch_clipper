library flutter_switch_clipper;

import 'package:flutter/material.dart';

///填充方向
enum FillAlignment { left, top, right, bottom }

///自定义裁剪
typedef SwitchCipperBuilder = CustomClipper<Path>? Function(Animation<double> animation, FillAlignment fillAlignment);

///SwitchCipper
class SwitchCipper extends StatefulWidget {
  const SwitchCipper({
    Key? key,
    required this.child,
    required this.background,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.bounceOut,
    this.reverseCurve = Curves.ease,
    this.isSelect,
    this.onSelect,
    this.fillAlignment = FillAlignment.left,
    this.fillOffset = 20,
    this.alignment = Alignment.center,
    this.customCipperBuilder,
    this.initSelect = false,
  }) : super(key: key);

  @override
  _SwitchCipperState createState() => _SwitchCipperState();

  ///上层Widget
  final Widget child;

  ///底层Widget
  final Widget background;

  ///* 动画持续时间
  ///* 默认 `const Duration(milliseconds: 500)`
  final Duration duration;

  ///* forward动画曲线
  ///* 默认`Curves.bounceOut`
  final Curve curve;

  ///* reverse动画曲线
  ///* 默认`Curves.ease`
  final Curve reverseCurve;

  ///* 选中状态
  ///* `isSelect!=null` 时 `onSelect` 将失效
  final bool? isSelect;

  ///* 初始化选中状态
  ///* 仅在widget创建时生效
  ///* 默认`false`
  final bool initSelect;

  ///* 点击回调
  ///* `result` 回调值
  ///* 函数返回值将控制此次点击是否生效
  final bool? Function(bool result)? onSelect;

  ///* 裁切起始方向
  ///* 默认 `FillAlignment.left`
  final FillAlignment fillAlignment;

  ///* 裁切弧度偏移量
  ///* 默认`20`
  final double fillOffset;

  ///* `child` 和 `background` 的对齐方式
  ///* 默认 `Alignment.center`
  final AlignmentGeometry alignment;

  ///自定义裁切
  final SwitchCipperBuilder? customCipperBuilder;
}

class _SwitchCipperState extends State<SwitchCipper> with SingleTickerProviderStateMixin {
  ///动画控制器
  late AnimationController _controller;

  ///自定义裁切
  CustomClipper<Path>? get _customClipper => widget.customCipperBuilder?.call(
        CurvedAnimation(
          parent: _controller,
          curve: widget.curve,
          reverseCurve: widget.reverseCurve,
        ),
        widget.fillAlignment,
      );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: widget.initSelect ? 1.0 : 0.0,
      vsync: this,
      duration: widget.duration,
    );

    if (widget.initSelect) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant SwitchCipper oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    if (widget.isSelect != null && widget.isSelect != oldWidget.isSelect) {
      if (widget.isSelect!) {
        _controller.forward();
        widget.onSelect?.call(true);
      } else {
        _controller.reverse();
        widget.onSelect?.call(false);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///点击回调
  void _onSelect() {
    if (_controller.isCompleted) {
      if (!(widget.onSelect?.call(false) ?? true)) return;
      _controller.reverse();
    } else {
      if (!(widget.onSelect?.call(true) ?? true)) return;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Stack(
      alignment: widget.alignment,
      children: <Widget>[
        widget.background,
        ClipPath(
          clipper: _customClipper ??
              _MaskClipper(
                animation: CurvedAnimation(
                  parent: _controller,
                  curve: widget.curve,
                  reverseCurve: widget.reverseCurve,
                ),
                fillAlignment: widget.fillAlignment,
                fillOffset: widget.fillOffset,
              ),
          child: widget.child,
        ),
      ],
    );

    if (widget.isSelect == null) {
      child = GestureDetector(
        onTap: _onSelect,
        child: child,
      );
    }

    return child;
  }
}

///裁切对象
class _MaskClipper extends CustomClipper<Path> {
  const _MaskClipper({
    required this.animation,
    this.fillAlignment = FillAlignment.left,
    this.fillOffset = 20,
  }) : super(reclip: animation);

  ///动画对象
  final Animation<double> animation;

  ///填充方向
  final FillAlignment fillAlignment;

  ///弧度偏移量
  final double fillOffset;

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
        ..quadraticBezierTo(w / 2, h * animation.value, 0, h * animation.value - fillOffset * (1 - animation.value))
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
            w / 2, (h - (fillOffset - 1)) * (1 - animation.value), 0, (h + fillOffset) * (1 - animation.value))
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
