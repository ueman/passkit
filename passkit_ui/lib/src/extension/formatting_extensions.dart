import 'package:flutter/widgets.dart';
import 'package:passkit/passkit.dart';

extension PkTextAlignmentExtension on PkTextAlignment {
  TextAlign flutterTextAlign(BuildContext context) {
    return switch (this) {
      PkTextAlignment.left => TextAlign.left,
      PkTextAlignment.center => TextAlign.center,
      PkTextAlignment.right => TextAlign.right,
      PkTextAlignment.natural => Directionality.of(context) == TextDirection.ltr
          ? TextAlign.left
          : TextAlign.right
    };
  }
}
