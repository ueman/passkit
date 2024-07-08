import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/theme/base_pass_theme.dart';

/// ThemeExtension for a boarding pass.
///
/// ![](https://docs-assets.developer.apple.com/published/1656e78a2371c7828d25a5c5ffcddad6/boarding@2x.png)
/// ![](https://docs-assets.developer.apple.com/published/d9c8d4f88fd387194d5349d1de1f8ede/boarding-pass-layout@2x.png)
///
/// See:
/// - https://developer.apple.com/design/human-interface-guidelines/wallet#Boarding-passes
class BoardingPassTheme extends ThemeExtension<BoardingPassTheme>
    implements BasePassTheme {
  BoardingPassTheme({
    required this.auxiliaryLabelStyle,
    required this.auxiliaryTextStyle,
    required this.primaryLabelStyle,
    required this.primaryTextStyle,
    required this.headerLabelStyle,
    required this.headerTextStyle,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.labelColor,
    required this.logoTextStyle,
  });

  factory BoardingPassTheme.fromPass(PkPass pass) {
    final backgroundColor =
        pass.pass.backgroundColor?.toDartUiColor() ?? Colors.white;
    final foregroundColor =
        pass.pass.foregroundColor?.toDartUiColor() ?? Colors.black;
    final labelColor = pass.pass.labelColor?.toDartUiColor() ?? Colors.black;
    final foregroundTextStyle = TextStyle(color: foregroundColor);
    final labelTextStyle = TextStyle(color: labelColor);

    return BoardingPassTheme(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      labelColor: labelColor,
      logoTextStyle: foregroundTextStyle.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      headerLabelStyle: labelTextStyle.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      headerTextStyle: foregroundTextStyle.copyWith(
        fontSize: 17,
        height: 0.9,
      ),
      primaryLabelStyle: TextStyle(
        color: labelColor,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      primaryTextStyle: TextStyle(
        color: foregroundColor,
        fontSize: 32,
        height: 0.9,
      ),
      auxiliaryLabelStyle: labelTextStyle.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      auxiliaryTextStyle: foregroundTextStyle.copyWith(
        fontSize: 12,
        height: 0.9,
      ),
    );
  }

  @override
  final Color backgroundColor;

  @override
  final Color foregroundColor;

  @override
  final Color labelColor;

  /// Should match the Headline text style from here for medium size devices
  /// https://developer.apple.com/design/human-interface-guidelines/typography
  final TextStyle logoTextStyle;

  /// Should match the Headline text style from here for medium size devices
  /// https://developer.apple.com/design/human-interface-guidelines/typography
  final TextStyle headerLabelStyle;
  final TextStyle headerTextStyle;

  final TextStyle primaryLabelStyle;
  final TextStyle primaryTextStyle;

  final TextStyle auxiliaryLabelStyle;
  final TextStyle auxiliaryTextStyle;

  @override
  ThemeExtension<BoardingPassTheme> copyWith() => this;

  @override
  ThemeExtension<BoardingPassTheme> lerp(
    covariant ThemeExtension<BoardingPassTheme>? other,
    double t,
  ) =>
      this;
}
