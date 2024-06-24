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
}

extension PkPassThemeExtension on PkPass {
  PassTheme get theme {
    return PassTheme(
      backgroundColor: pass.backgroundColor?.toDartUiColor() ?? Colors.white,
      foregroundColor: pass.foregroundColor?.toDartUiColor() ?? Colors.black,
      labelColor: pass.labelColor?.toDartUiColor() ?? Colors.black,
    );
  }
}
