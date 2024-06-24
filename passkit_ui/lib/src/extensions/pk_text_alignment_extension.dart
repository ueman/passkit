import 'package:flutter/widgets.dart';
import 'package:passkit/passkit.dart';

extension PkTextAlignmentX on PkTextAlignment {
  TextAlign flutterTextAlign({required TextDirection textDirection}) {
    return switch (this) {
      PkTextAlignment.left => TextAlign.left,
      PkTextAlignment.center => TextAlign.center,
      PkTextAlignment.right => TextAlign.right,
      PkTextAlignment.natural when textDirection == TextDirection.ltr =>
        TextAlign.left,
      PkTextAlignment.natural when textDirection == TextDirection.rtl =>
        TextAlign.right,
      _ => TextAlign.left,
    };
  }
}
