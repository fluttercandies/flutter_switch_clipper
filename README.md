# Flutter Switch Clipper

A Flutter package that two widgets switch with clipper.

### 使用

> 使用FillClipper并自定义相关参数 

<img src="https://raw.githubusercontent.com/fluttercandies/flutter_switch_clipper/master/preview/fv.gif" height=100>

```dart
SwitchCipper(
    initSelect: true,
    child: const Icon(Icons.favorite, size: 200, color: Colors.redAccent),
    background: const Icon(Icons.favorite, size: 200, color: Colors.white),
    duration: const Duration(milliseconds: 800),
    customCipperBuilder: (Animation<double> animation) => FillClipper(
        animation: animation,
        fillAlignment: _alignment,
        fillOffset: 50,
    ),
),
```
> 使用默认FillClipper 

<img src="https://raw.githubusercontent.com/fluttercandies/flutter_switch_clipper/master/preview/fc.gif" height=100>

```dart
const SwitchCipper(
    enableWhenAnimating: false,
    child: Text(
        'FlutterCandies',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
            color: Colors.amber,
            height: 2,
        ),
    ),
    background: Text(
        'FlutterCandies',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
            color: Colors.white,
            height: 2,
        ),
    ),
    curve: Curves.slowMiddle,
    reverseCurve: Curves.linear,
),
```
> 使用CircleClipper切换图标颜色 

<img src="https://raw.githubusercontent.com/fluttercandies/flutter_switch_clipper/master/preview/cs.gif" height=100>

```dart
SwitchCipper(
    child: const Icon(Icons.accessibility_new_rounded, size: 200, color: Colors.blueAccent),
    background: const Icon(Icons.accessibility_new_rounded, size: 200, color: Colors.white),
    curve: Curves.ease,
    duration: const Duration(milliseconds: 800),
    customCipperBuilder: (Animation<double> animation) => CircleClipper(animation: animation),
),
```

> 使用CircleClipper切换两个图标 

<img src="https://raw.githubusercontent.com/fluttercandies/flutter_switch_clipper/master/preview/cs2.gif" height=100>

```dart
SwitchCipper(
    child: ColoredBox(
    color: Colors.blueGrey[200] ?? Colors.blueGrey,
    child: const Icon(Icons.accessibility_new_rounded, size: 200, color: Colors.white)),
    background: const Icon(Icons.accessible_forward_outlined, size: 200, color: Colors.white),
    curve: Curves.ease,
    duration: const Duration(milliseconds: 800),
    customCipperBuilder: (Animation<double> animation) => CircleClipper(animation: animation),
),
```

> 使用ShutterClipper 

<img src="https://raw.githubusercontent.com/fluttercandies/flutter_switch_clipper/master/preview/cs3.gif" height=100>

```dart
SwitchCipper(
    child: ColoredBox(
        color: Colors.blueGrey[200] ?? Colors.blueGrey,
        child: const Icon(Icons.accessibility_new_rounded, size: 200, color: Colors.white)),
    background: const Icon(Icons.accessible_forward_outlined, size: 200, color: Colors.white),
    curve: Curves.ease,
    duration: const Duration(milliseconds: 800),
    customCipperBuilder: (Animation<double> animation) => ShutterClipper(
        animation: animation,
        activeAlignment: _alignment,
    ),
),
```

### 体验一下

体验网址:[https://sc.liugl.cn](https://sc.liugl.cn)

