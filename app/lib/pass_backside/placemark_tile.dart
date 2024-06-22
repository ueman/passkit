import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class PlacemarkTile extends StatelessWidget {
  const PlacemarkTile({
    super.key,
    required this.placemark,
    required this.onPlacemarkTap,
  });

  final Placemark placemark;
  final ValueChanged<Placemark> onPlacemarkTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(placemark.toString()),
      onTap: () => onPlacemarkTap(placemark),
    );
  }
}
