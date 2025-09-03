import 'dart:ui';

import 'package:csslib/parser.dart' as css;

extension FlutterColor on css.Color {
  Color toDartUiColor() => Color.fromARGB(255, rgba.r, rgba.g, rgba.b);
}

extension CssColor on Color {
  css.Color toCssColor() => css.Color.createRgba(red, green, blue);
}
