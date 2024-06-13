import 'package:flutter/material.dart';
import 'package:flutter_switch_clipper/flutter_switch_clipper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey[200],
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(40),
          children: <Widget>[
            const SwitchCipper(
              initSelect: true,
              child: Icon(Icons.favorite, size: 200, color: Colors.redAccent),
              background: Icon(Icons.favorite, size: 200, color: Colors.white),
              duration: Duration(milliseconds: 800),

              /// 使用FillClipper并自定义相关参数
              animationClip: FillClipper(fillOffset: 50),
            ),

            /// 默认FillClipper
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

            Wrap(
              children: <Widget>[
                /// 使用ShutterClipper
                SwitchCipper(
                  child: ColoredBox(
                    color: Colors.blueGrey[200] ?? Colors.blueGrey,
                    child: const Icon(Icons.accessibility_new_rounded,
                        size: 200, color: Colors.white),
                  ),
                  background: const Icon(Icons.accessible_forward_outlined,
                      size: 200, color: Colors.white),
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 800),
                  animationClip: ShutterClipper(),
                ),

                /// 使用CircleClipper切换图标颜色
                SwitchCipper(
                  child: const Icon(Icons.accessibility_new_rounded,
                      size: 200, color: Colors.blueAccent),
                  background: const Icon(Icons.accessibility_new_rounded,
                      size: 200, color: Colors.white),
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 800),
                  animationClip: CircleClipper(),
                ),

                /// 使用CircleClipper切换两个图标
                SwitchCipper(
                  child: ColoredBox(
                    color: Colors.blueGrey[200] ?? Colors.blueGrey,
                    child: const Icon(Icons.accessibility_new_rounded,
                        size: 200, color: Colors.white),
                  ),
                  background: const Icon(Icons.accessible_forward_outlined,
                      size: 200, color: Colors.white),
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 800),
                  animationClip: CircleClipper(),
                ),

                /// 使用WaveClipper切换图标颜色
                SwitchCipper(
                  child: const Icon(Icons.access_time_filled_rounded,
                      size: 200, color: Colors.blue),
                  // child: Container(width: 200, height: 200, color: Colors.blue),
                  background: const Icon(Icons.access_time_filled_rounded,
                      size: 200, color: Colors.white),
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 2000),
                  animationClip: WaveClipper(),
                ),

                /// 使用CameraClipper切换图标颜色
                SwitchCipper(
                  // child: const Icon(Icons.access_time_filled_rounded, size: 200, color: Colors.blue),
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
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // background: const Icon(Icons.access_time_filled_rounded, size: 200, color: Colors.white),
                  background: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  duration: const Duration(milliseconds: 1500),
                  animationClip: CameraClipper(),
                ),
              ],
            ),
            const SizedBox(height: 40),

            const Text('点击上方图标或文本预览效果'),
          ],
        ),
      ),
    );
  }
}
