# flutter_switch_clipper

A Flutter package that two widgets switch with clipper.

## 1.使用

<img src="https://raw.githubusercontent.com/fluttercandies/flutter_switch_clipper/master/preview/fv.gif" height=100>
<img src="https://raw.githubusercontent.com/fluttercandies/flutter_switch_clipper/master/preview/fc.gif" height=100>

```dart
SwitchCipper(
    initSelect: true,
    child: const Icon(Icons.favorite, size: 200, color: Colors.redAccent),
    background: const Icon(Icons.favorite, size: 200, color: Colors.white),
    fillAlignment: _alignment,
    fillOffset: 50,
    duration: const Duration(milliseconds: 800),
    onSelect: (bool r) {
        print(r);
    },
),
```

```dart
SwitchCipper(
    child: const Text(
        'FlutterCandies',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
            color: Colors.amber,
            height: 2,
        ),
    ),
    background: const Text(
        'FlutterCandies',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
            color: Colors.white,
            height: 2,
        ),
    ),
    fillAlignment: _alignment,
    curve: Curves.slowMiddle,
    reverseCurve: Curves.linear,
    fillOffset: 10,
),
```
<img src="https://raw.githubusercontent.com/fluttercandies/flutter_switch_clipper/master/preview/cs.gif" height=100>

```dart
SwitchCipper(
    child: const Icon(Icons.accessibility_new_rounded, size: 200, color: Colors.blueAccent),
    background: const Icon(Icons.accessibility_new_rounded, size: 200, color: Colors.white),
    curve: Curves.ease,
    duration: const Duration(milliseconds: 800),
    customCipperBuilder: (Animation<double> animation, _) => CircleClipper(animation: animation),
),
```
```dart
///自定义Clipper
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
          radius: (size.longestSide / 2) * animation.value,
        ),
      );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
```

## 体验一下

体验网址:[https://sc.liugl.cn](https://sc.liugl.cn)

