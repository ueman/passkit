import 'package:flutter/material.dart';
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

  CrossAxisAlignment toCrossAxisAlign() {
    return switch (this) {
      PkTextAlignment.left => CrossAxisAlignment.start,
      PkTextAlignment.center => CrossAxisAlignment.center,
      PkTextAlignment.right => CrossAxisAlignment.start,
      PkTextAlignment.natural => CrossAxisAlignment.start,
    };
  }
}
