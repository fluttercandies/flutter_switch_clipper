# Flutter Switch Clipper

A Flutter package that two widgets switch with clipper. 

[![pub package](https://img.shields.io/pub/v/flutter_switch_clipper?logo=dart&label=stable&style=flat-square)](https://pub.dev/packages/flutter_switch_clipper)
[![GitHub stars](https://img.shields.io/github/stars/fluttercandies/flutter_switch_clipper?logo=github&style=flat-square)](https://github.com/fluttercandies/flutter_switch_clipper/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/fluttercandies/flutter_switch_clipper?logo=github&style=flat-square)](https://github.com/fluttercandies/flutter_switch_clipper/network/members)
[![CodeFactor](https://img.shields.io/codefactor/grade/github/fluttercandies/flutter_switch_clipper?logo=codefactor&logoColor=%23ffffff&style=flat-square)](https://www.codefactor.io/repository/github/fluttercandies/flutter_switch_clipper)
<a target="_blank" href="https://jq.qq.com/?_wv=1027&k=5bcc0gy"><img border="0" src="https://pub.idqqimg.com/wpa/images/group.png" alt="FlutterCandies" title="FlutterCandies"></a>

### 使用

> 使用FillClipper并自定义相关参数 

<img src="https://raw.githubusercontent.com/fluttercandies/flutter_switch_clipper/master/preview/fv.gif" height=100>
<details>
  <summary>View code</summary>

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
</details>

<br>

> 使用默认FillClipper 

<img src="https://raw.githubusercontent.com/fluttercandies/flutter_switch_clipper/master/preview/fc.gif" height=100>

<details>
  <summary>View code</summary>

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

</details>

<br>

> 使用CircleClipper切换图标颜色 

<img src="https://raw.githubusercontent.com/fluttercandies/flutter_switch_clipper/master/preview/cs.gif" height=100>

<details>
  <summary>View code</summary>

```dart
SwitchCipper(
    child: const Icon(Icons.accessibility_new_rounded, size: 200, color: Colors.blueAccent),
    background: const Icon(Icons.accessibility_new_rounded, size: 200, color: Colors.white),
    curve: Curves.ease,
    duration: const Duration(milliseconds: 800),
    customCipperBuilder: (Animation<double> animation) => CircleClipper(animation: animation),
),
```

</details>

<br>

> 使用CircleClipper切换两个图标 

<img src="https://raw.githubusercontent.com/fluttercandies/flutter_switch_clipper/master/preview/cs2.gif" height=100>

<details>
  <summary>View code</summary>

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

</details>

<br>

> 使用ShutterClipper 

<img src="https://raw.githubusercontent.com/fluttercandies/flutter_switch_clipper/master/preview/cs3.gif" height=100>

<details>
  <summary>View code</summary>

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

</details>

<br>

> 使用WaveClipper 

<img src="https://raw.githubusercontent.com/fluttercandies/flutter_switch_clipper/master/preview/cs4.gif" height=100>

<details>
  <summary>View code</summary>

```dart
SwitchCipper(
    child: const Icon(Icons.access_time_filled_rounded, size: 200, color: Colors.blue),
    background: const Icon(Icons.access_time_filled_rounded, size: 200, color: Colors.white),
    curve: Curves.ease,
    duration: const Duration(milliseconds: 2000),
    customCipperBuilder: (Animation<double> animation) => WaveClipper(
        animation: animation,
        waveAlignment: _alignment == FillAlignment.left ? WaveAlignment.left : WaveAlignment.right,
    ),
),
```

</details>

<br>

> 使用CameraClipper 

<img src="https://raw.githubusercontent.com/fluttercandies/flutter_switch_clipper/master/preview/cs5.gif" height=100>

<details>
  <summary>View code</summary>

```dart
SwitchCipper(
    child: Container(
        width: 200,
        height: 200,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
        ),
        child: const Text(
            'Camera',
            style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        ),
    ),
    background: Container(
        width: 200,
        height: 200,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
        ),
    ),
    duration: const Duration(milliseconds: 2000),
    customCipperBuilder: (Animation<double> animation) => CameraClipper(
        animation: animation,
    ),
),
```

</details>

### 体验一下

体验网址:[https://sc.liugl.cn](https://sc.liugl.cn)

