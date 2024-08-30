import 'package:csslib/parser.dart';

Color? parseColor(String? color) {
  if (color == null) {
    return null;
  }
  return Color.css(color);
}

String? colorToString(Color? color) {
  if (color == null) {
    return null;
  }
  return color.cssExpression;
}
