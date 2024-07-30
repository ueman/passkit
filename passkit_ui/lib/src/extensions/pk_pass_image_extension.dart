import 'dart:typed_data';

import 'package:passkit/passkit.dart';

extension PkPassImageX on PkImage {
  Uint8List forCorrectPixelRatio(double devicePixelRatio) {
    // It just looks better when using images a step higher.
    return fromMultiplier(devicePixelRatio.toInt() + 1);
  }
}
