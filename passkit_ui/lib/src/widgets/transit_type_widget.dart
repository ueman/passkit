import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/widgets/plane_icon.dart';

class TransitTypeWidget extends StatelessWidget {
  const TransitTypeWidget({
    super.key,
    required this.transitType,
    required this.width,
    required this.color,
  });

  final TransitType transitType;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return switch (transitType) {
      TransitType.air => PlaneIcon(color: color, width: width),
      TransitType.boat => PlaneIcon(color: color, width: width),
      TransitType.bus => PlaneIcon(color: color, width: width),
      TransitType.generic => PlaneIcon(color: color, width: width),
      TransitType.train => PlaneIcon(color: color, width: width),
    };
  }
}
