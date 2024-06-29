// TODO(any): Make [PassTheme] a Theme extension.

import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

class PassTheme {
  PassTheme({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.labelColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color labelColor;

  TextStyle get foregroundTextStyle => TextStyle(color: foregroundColor);
  TextStyle get backgroundTextStyle => TextStyle(color: backgroundColor);
  TextStyle get labelTextStyle => TextStyle(color: labelColor);

  // Width and height were professionally eyeballed from a screenshot from the
  // wallet app on iOS.
  // In https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1
  // the strip images are described to be 320 wide, so the dimensions are at
  // least somewhat reasonable.
  // TODO(ueman): Figure out the correct dimensions
  double height = 460;
  double width = 320;
}

extension PkPassThemeX on PkPass {
  PassTheme get theme {
    return PassTheme(
      backgroundColor: pass.backgroundColor?.toDartUiColor() ?? Colors.white,
      foregroundColor: pass.foregroundColor?.toDartUiColor() ?? Colors.black,
      labelColor: pass.labelColor?.toDartUiColor() ?? Colors.black,
    );
  }
}
