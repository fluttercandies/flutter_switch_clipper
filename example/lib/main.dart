import 'dart:ui';

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
  FillAlignment _alignment = FillAlignment.left;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(40),
          children: <Widget>[
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
            const SizedBox(height: 40),
            ...FillAlignment.values
                .map((FillAlignment alignment) => RadioListTile<FillAlignment>(
                      value: alignment,
                      groupValue: _alignment,
                      title: Text(alignment.toString()),
                      contentPadding: EdgeInsets.zero,
                      onChanged: (_) {
                        setState(() => _alignment = alignment);
                      },
                    ))
                .toList(),
            const SizedBox(height: 40),
            const Text('点击上方图标或文本预览效果'),
          ],
        ),
      ),
    );
  }
}
