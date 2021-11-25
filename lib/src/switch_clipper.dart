import 'package:flutter/material.dart';

import 'clippers/fill_clipper.dart';

/// 自定义裁剪
typedef SwitchCipperBuilder = CustomClipper<Path>? Function(
    Animation<double> animation);

/// 动画执行状态回调
typedef OnAnimationStatusChanged = Function(AnimationStatus animationStatus);

/// SwitchCipper
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
    this.alignment = Alignment.center,
    this.customCipperBuilder,
    this.initSelect = false,
    this.onAnimationComplate,
    this.value,
    this.hasAnimationWhenValueChanged = true,
    this.enableWhenAnimating = true,
  }) : super(key: key);

  @override
  _SwitchCipperState createState() => _SwitchCipperState();

  /// 上层Widget
  final Widget child;

  /// 底层Widget
  final Widget background;

  /// * 动画持续时间
  /// * 默认 `const Duration(milliseconds: 500)`
  final Duration duration;

  /// * forward动画曲线
  /// * 默认`Curves.bounceOut`
  final Curve curve;

  /// * reverse动画曲线
  /// * 默认`Curves.ease`
  final Curve reverseCurve;

  /// * 选中状态
  /// * `isSelect!=null` 时 `onSelect` 将失效
  final bool? isSelect;

  /// * 当前值
  /// * 会覆盖 `isSelect` 和 `initSelect`
  final double? value;

  /// * value变化时是否有动画
  /// * 默认`true`
  final bool hasAnimationWhenValueChanged;

  /// * 初始化选中状态
  /// * 仅在widget创建时生效
  /// * 默认`false`
  final bool initSelect;

  /// * 点击回调
  /// * `result` 回调值
  /// * 函数返回值将控制此次点击是否生效
  final bool? Function(bool result)? onSelect;

  /// * `child` 和 `background` 的对齐方式
  /// * 默认 `Alignment.center`
  final AlignmentGeometry alignment;

  /// * 自定义裁切
  /// * 默认 `FillClipper`
  final SwitchCipperBuilder? customCipperBuilder;

  /// 动画执行状态回调
  final OnAnimationStatusChanged? onAnimationComplate;

  /// * 动画能否被打断
  /// * `if(!enableWhenAnimating)` 动画必须执行完毕才能进行下一步动作
  /// * 默认 `true`
  final bool enableWhenAnimating;
}

class _SwitchCipperState extends State<SwitchCipper>
    with SingleTickerProviderStateMixin {
  /// 动画控制器
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _initClipper();
  }

  @override
  void didUpdateWidget(covariant SwitchCipper oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleUpdate(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 初始化
  void _initClipper() {
    _controller = AnimationController(
      value: widget.value ?? (widget.initSelect ? 1.0 : 0.0),
      vsync: this,
      duration: widget.duration,
    );

    _handleValue();

    if (widget.value == null && widget.initSelect) {
      _controller.forward();
      widget.onAnimationComplate?.call(AnimationStatus.completed);
    }
  }

  /// 处理外部更新
  void _handleUpdate(covariant SwitchCipper oldWidget) {
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    if (widget.value != null && widget.value != oldWidget.value) {
      _handleValue(old: oldWidget.value, now: widget.value);
    } else {
      if (widget.isSelect != null && widget.isSelect != oldWidget.isSelect) {
        if (widget.isSelect!) {
          _forward();
        } else {
          _reverse();
        }
      }
    }
  }

  /// * 处理 `widget.value`
  Future<void> _handleValue({double? old, double? now}) async {
    if (widget.value == null) return;

    //新旧值都存在时，判断动画方向
    if (old != null && now != null && widget.hasAnimationWhenValueChanged) {
      if (now > old) {
        //forward
        if (now >= 1) {
          _controller.animateTo(1.0);
          widget.onAnimationComplate?.call(AnimationStatus.completed);
        } else {
          _controller.animateTo(now);
        }
      } else {
        //reverse
        if (now <= 0) {
          _controller.animateBack(0.0);
          widget.onAnimationComplate?.call(AnimationStatus.dismissed);
        } else {
          _controller.animateBack(now);
        }
      }
    } else if (widget.value! <= 0) {
      _controller.value = 0.0;
      _controller.reverse();
      widget.onAnimationComplate?.call(AnimationStatus.dismissed);
    } else if (widget.value! >= 1) {
      _controller.value = 1.0;
      _controller.forward();
      widget.onAnimationComplate?.call(AnimationStatus.completed);
    } else {
      _controller.value = widget.value!;
    }
  }

  /// reverse
  Future<void> _reverse() async {
    widget.onAnimationComplate?.call(AnimationStatus.reverse);
    await _controller.reverse();
    widget.onAnimationComplate?.call(AnimationStatus.dismissed);
  }

  /// forward
  Future<void> _forward() async {
    widget.onAnimationComplate?.call(AnimationStatus.forward);
    await _controller.forward();
    widget.onAnimationComplate?.call(AnimationStatus.completed);
  }

  /// 点击回调
  Future<void> _onSelect() async {
    if (!widget.enableWhenAnimating) {
      if (_controller.isCompleted) {
        if (!(widget.onSelect?.call(false) ?? true)) return;
        await _reverse();
      } else if (_controller.isDismissed) {
        if (!(widget.onSelect?.call(true) ?? true)) return;
        await _forward();
      }
    } else {
      if (_controller.status == AnimationStatus.reverse ||
          _controller.isDismissed) {
        await _forward();
      } else if (_controller.status == AnimationStatus.forward ||
          _controller.isCompleted) {
        await _reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Stack(
      alignment: widget.alignment,
      children: <Widget>[
        widget.background,
        ClipPath(clipper: _clipper, child: widget.child),
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

  ///自定义裁切
  CustomClipper<Path> get _clipper =>
      widget.customCipperBuilder?.call(
        CurvedAnimation(
          parent: _controller,
          curve: widget.curve,
          reverseCurve: widget.reverseCurve,
        ),
      ) ??
      FillClipper(
        animation: CurvedAnimation(
          parent: _controller,
          curve: widget.curve,
          reverseCurve: widget.reverseCurve,
        ),
      );
}
