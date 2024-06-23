import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';

extension PkPassImageExtension on PkPassImage {
  Uint8List forCorrectPixelRatio(BuildContext context) {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context).toInt();
    // It just looks better when using images a step higher
    return fromMultiplier(pixelRatio + 1);
  }
}
