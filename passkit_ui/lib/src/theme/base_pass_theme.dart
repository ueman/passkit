import 'package:flutter/material.dart';

abstract interface class BasePassTheme {
  Color get backgroundColor;
  Color get foregroundColor;
  Color get labelColor;

  TextStyle get logoTextStyle;

  TextStyle get headerLabelStyle;
  TextStyle get headerTextStyle;
}
