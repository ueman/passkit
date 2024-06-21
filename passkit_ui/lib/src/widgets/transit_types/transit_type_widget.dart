import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/widgets/transit_types/bus_icon.dart';
import 'package:passkit_ui/src/widgets/transit_types/generic_transit_type.dart';
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
      TransitType.boat => PlaneIcon(color: color, width: width),
      TransitType.bus => BusIcon(color: color, width: width),
      TransitType.train => PlaneIcon(color: color, width: width),
      TransitType.generic => GenericTransitType(color: color, size: width),
    };
  }
}
