import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation_demo/animated_box.dart';
import 'package:flutter_animation_demo/secondpage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
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
    "Ease In And Out Sine": Curves.easeInOutSine
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
    var curvedAnimation = CurvedAnimation(
        curve: StopCurve(parent: animationCurve), parent: controller);
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation Test"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 125),
                  child: ScaledAndRotatedBoxHero(
                    scale: Tween(begin: startSize, end: endSize)
                        .evaluate(curvedAnimation),
                    rotation: Tween(begin: 0.0, end: 2 * pi * totalTurns)
                        .evaluate(curvedAnimation),
                  )),
              ElevatedButton(
                child: controller.isAnimating
                    ? Icon(Icons.stop)
                    : Icon(Icons.play_arrow),
                onPressed: () => controller.isAnimating
                    ? setState(() => controller.stop())
                    : controller.repeat(),
              ),
              Divider(),
              Text("animation Position:"),
              Slider(
                value: curvedAnimation.value,
                min: 0.0,
                max: 1.0,
                onChanged: null,
                //onChanged: (value) => controller.animateTo(value)
              ),
              Text("Roation Speed:"),
              Slider(
                value: totalTurns,
                min: -maxTurns,
                max: maxTurns,
                //divisions: (2 * maxTurns / turnDiv).floor(),
                onChanged: (value) => setState(() {
                  totalTurns = value;
                }),
              ),
              Text("Start Size:"),
              Slider(
                value: startSize,
                min: 0.0,
                max: maxSize,
                onChanged: (value) => setState(() {
                  startSize = value;
                }),
              ),
              Text("End Size:"),
              Slider(
                value: endSize,
                min: 0.0,
                max: maxSize,
                onChanged: (value) => setState(() {
                  endSize = value;
                }),
              ),
              DropdownButton(
                items: curves.keys
                    .map((e) => DropdownMenuItem(
                          child: Text("$e"),
                          value: curves[e],
                        ))
                    .toList(),
                onChanged: (value) => setState(() {
                  animationCurve = value ?? animationCurve;
                }),
                value: animationCurve,
              ),
              TextButton(
                  onPressed: () =>
                      Navigator.push(context, secondPageRoute(context)),
                  child: Text('Next'))
            ],
          ),
        ),
      ),
    );
  }
}

class StopCurve extends Curve {
  final double stopTime;
  final Curve parent;
  const StopCurve({required this.parent, this.stopTime = 0.8});

  @override
  double transformInternal(double t) {
    return min(parent.transform(t), stopTime) * 1 / stopTime;
    // TODO: implement transformInternal
    // return super.transformInternal(t);
  }
}
