import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation_demo/mainpage.dart';
import 'package:flutter_animation_demo/secondpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  double totalTurns = 0;
  final double maxTurns = 1;
  final double turnDiv = 0.25;
  double startSize = 1.0;
  double endSize = 1.0;
  final double maxSize = 2.0;

  final curves = {
    "Linear": Curves.linear,
    "Ease In": Curves.easeIn,
    "Ease Out": Curves.easeOut,
    "Ease In And Out": Curves.easeInOut,
    "Ease Out Sine": Curves.easeOutSine,
    "Ease In Sine": Curves.easeInSine,
    "Ease In Aout Sine": Curves.easeInOutSine
  };

  Curve animationCurve = Curves.linear;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..repeat()
          ..addListener(() {
            setState(() {});
          });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(controller.isAnimating);
    return MaterialApp(
      routes: {
        '/': (context) => MainPage(),
      },
      initialRoute: '/',
    );
  }
}
