import 'package:flutter/material.dart';

class Squircle extends StatelessWidget {
  const Squircle({super.key, required this.radius, required this.child});

  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.all(Radius.circular(radius));

    return ClipPath(
      clipper: ShapeBorderClipper(
        shape: ContinuousRectangleBorder(borderRadius: r),
      ),
      child: child,
    );
  }
}
