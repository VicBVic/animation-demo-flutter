import 'package:flutter/material.dart';

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
    var curvedAnimation =
        CurvedAnimation(curve: animationCurve, parent: controller);
    return MaterialApp(
      home: Scaffold(
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
                  child: ScaleTransition(
                    scale: Tween(begin: startSize, end: endSize)
                        .animate(curvedAnimation),
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: totalTurns)
                          .animate(curvedAnimation),
                      child: SizedBox(
                        height: 250,
                        width: 250,
                        child: Container(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
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
                  value: controller.value,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
