import 'package:flutter/widgets.dart';
import 'package:passkit/passkit.dart';

extension PkTextAlignmentX on PkTextAlignment {
  TextAlign toFlutterTextAlign() {
    return switch (this) {
      PkTextAlignment.left => TextAlign.left,
      PkTextAlignment.center => TextAlign.center,
      PkTextAlignment.right => TextAlign.right,
      PkTextAlignment.natural => TextAlign.start,
    };
  }
}
