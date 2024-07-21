import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/theme/base_pass_theme.dart';

/// ThemeExtension for a generic pass.
///
/// ![](https://docs-assets.developer.apple.com/published/2f8c9366433d611399132b3075659cba/generic@2x.png)
/// ![](https://docs-assets.developer.apple.com/published/0ea8eaf5a48417f07aed39a2e317710e/generic-pass-layout-1@2x.png)
/// ![](https://docs-assets.developer.apple.com/published/17f44895905b4c1e99b22bdab5c2842f/generic-pass-layout-2@2x.png)
///
/// See:
/// - https://developer.apple.com/design/human-interface-guidelines/wallet#Generic-passes
class GenericPassTheme extends ThemeExtension<GenericPassTheme>
    implements BasePassTheme {
  GenericPassTheme({
    required this.auxiliaryLabelStyle,
    required this.auxiliaryTextStyle,
    required this.headerLabelStyle,
    required this.headerTextStyle,
    required this.primaryWithThumbnailLabelStyle,
    required this.primaryWithThumbnailTextStyle,
    required this.secondaryWithThumbnailLabelStyle,
    required this.secondaryWithThumbnailTextStyle,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.labelColor,
    required this.logoTextStyle,
  });

  factory GenericPassTheme.fromPass(PkPass pass) {
    final backgroundColor =
        pass.pass.backgroundColor?.toDartUiColor() ?? Colors.white;
    final foregroundColor =
        pass.pass.foregroundColor?.toDartUiColor() ?? Colors.black;
    final labelColor = pass.pass.labelColor?.toDartUiColor() ?? Colors.black;
    final foregroundTextStyle = TextStyle(color: foregroundColor);
    final labelTextStyle = TextStyle(color: labelColor);

    return GenericPassTheme(
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
      auxiliaryLabelStyle: labelTextStyle.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      auxiliaryTextStyle: foregroundTextStyle.copyWith(
        fontSize: 12,
        height: 0.9,
      ),
      primaryWithThumbnailLabelStyle: TextStyle(
        color: foregroundColor,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      primaryWithThumbnailTextStyle: TextStyle(
        color: foregroundColor,
        fontSize: 30,
        height: 0.9,
      ),
      secondaryWithThumbnailLabelStyle: labelTextStyle.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      secondaryWithThumbnailTextStyle: foregroundTextStyle.copyWith(
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
  @override
  final TextStyle logoTextStyle;

  /// Should match the Headline text style from here for medium size devices
  /// https://developer.apple.com/design/human-interface-guidelines/typography
  @override
  final TextStyle headerLabelStyle;
  @override
  final TextStyle headerTextStyle;

  final TextStyle primaryWithThumbnailLabelStyle;
  final TextStyle primaryWithThumbnailTextStyle;

  final TextStyle secondaryWithThumbnailLabelStyle;
  final TextStyle secondaryWithThumbnailTextStyle;

  final TextStyle auxiliaryLabelStyle;
  final TextStyle auxiliaryTextStyle;

  @override
  ThemeExtension<GenericPassTheme> copyWith() => this;

  @override
  ThemeExtension<GenericPassTheme> lerp(
    covariant ThemeExtension<GenericPassTheme>? other,
    double t,
  ) =>
      this;
}
