import 'package:csslib/parser.dart';

Color? parseColor(String? color) {
  if (color == null) {
    return null;
  }
  return Color.css(color);
}

Color? colorToString(Color? color) {
  return null;
}
