import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/widgets/transit_types/bus_icon.dart';
import 'package:passkit_ui/src/widgets/transit_types/plane_icon.dart';

class TransitTypeWidget extends StatelessWidget {
  const TransitTypeWidget({
    super.key,
    required this.transitType,
    required this.width,
    required this.height,
    required this.color,
  });

  final TransitType transitType;
  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return switch (transitType) {
      TransitType.air => PlaneIcon(color: color, width: width),
      TransitType.boat =>
        Icon(Icons.directions_boat, size: width, color: color),
      TransitType.bus => BusIcon(color: color, width: width),
      TransitType.train =>
        Icon(CupertinoIcons.train_style_one, size: width, color: color),
      TransitType.generic =>
        Icon(Icons.arrow_right_alt_rounded, size: width + 10, color: color),
    };
  }
}
