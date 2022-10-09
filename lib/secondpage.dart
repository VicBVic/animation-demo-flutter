import 'package:flutter/material.dart';

import 'animated_box.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  double scale = 1.0;
  final double scaleIncrement = 1.2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salut"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Lume'),
            AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: ScaledAndRotatedBoxHero(
                scale: scale,
                rotation: 0.0,
                autoScale: false,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => setState(() {
                    scale /= scaleIncrement;
                  }),
                  child: Text(
                    "Smaller",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() {
                    scale *= scaleIncrement;
                  }),
                  child: Text(
                    "Bigger",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.black),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Route secondPageRoute(BuildContext context) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SecondPage(),
    transitionDuration: Duration(seconds: 1),
    reverseTransitionDuration: Duration(seconds: 1),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: RotationTransition(
        turns: animation,
        child: child,
      ),
    ),
  );
}
