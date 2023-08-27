import 'dart:ui';

import 'package:csslib/parser.dart' as css;

extension FlutterColor on css.Color {
  Color toDartUiColor() => Color.fromARGB(255, rgba.r, rgba.g, rgba.b);
}
