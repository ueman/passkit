import 'package:flutter/material.dart';

class GenericTransitType extends StatelessWidget {
  const GenericTransitType({
    super.key,
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_right_alt_rounded,
      color: color,
      size: size + 10,
    );
  }
}
