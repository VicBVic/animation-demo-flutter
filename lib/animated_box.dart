import 'dart:ui';

import 'package:flutter/material.dart';

class ScaledAndRotatedBoxHero extends StatelessWidget {
  final double scale;
  final double rotation;
  final bool autoScale;
  const ScaledAndRotatedBoxHero(
      {super.key,
      required this.scale,
      required this.rotation,
      this.autoScale = true});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'box',
        flightShuttleBuilder: (flightContext, animation, flightDirection,
            fromHeroContext, toHeroContext) {
          bool pushed = flightDirection == HeroFlightDirection.push;
          final box1 =
              (fromHeroContext.widget as Hero).child as ScaledAndRotatedBox;
          final box2 =
              (toHeroContext.widget as Hero).child as ScaledAndRotatedBox;

          return AnimatedBuilder(
            builder: (context, child) {
              return ScaledAndRotatedBoxHero(
                scale: lerpDouble(box1.scale, box2.scale,
                        pushed ? animation.value : 1 - animation.value) ??
                    0,
                rotation: lerpDouble(box1.rotation, box2.rotation,
                        pushed ? animation.value : 1 - animation.value) ??
                    0,
              );
            },
            animation: animation,
            child: null,
          );
        },
        child: ScaledAndRotatedBox(
          rotation: rotation,
          scale: scale,
          autoScale: autoScale,
        ));
  }
}

class ScaledAndRotatedBox extends StatelessWidget {
  final double scale;
  final double rotation;
  final bool autoScale;
  const ScaledAndRotatedBox(
      {super.key,
      required this.scale,
      required this.rotation,
      this.autoScale = true});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: autoScale
          ? Transform.scale(
              scale: scale,
              child: SizedBox(
                height: 250,
                width: 250,
                child: Container(color: Colors.blue),
              ),
            )
          : AnimatedScale(
              scale: scale,
              duration: Duration(milliseconds: 300),
              child: SizedBox(
                height: 250,
                width: 250,
                child: Container(color: Colors.blue),
              )),
    );
  }
}
