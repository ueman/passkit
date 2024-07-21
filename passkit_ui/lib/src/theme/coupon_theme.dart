import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/theme/base_pass_theme.dart';

/// ThemeExtension for a coupon pass.
///
/// ![](https://docs-assets.developer.apple.com/published/69bfb27a52f67ad10eb88d66276d0fa8/coupon@2x.png)
/// ![](https://docs-assets.developer.apple.com/published/e9ff886bf6d8e3f3202e165f5e0e5889/coupon-pass-layout@2x.png)
///
/// See:
/// - https://developer.apple.com/design/human-interface-guidelines/wallet#Coupons
class CouponTheme extends ThemeExtension<CouponTheme> implements BasePassTheme {
  CouponTheme({
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

  factory CouponTheme.fromPass(PkPass pass) {
    final backgroundColor =
        pass.pass.backgroundColor?.toDartUiColor() ?? Colors.white;
    final foregroundColor =
        pass.pass.foregroundColor?.toDartUiColor() ?? Colors.black;
    final labelColor = pass.pass.labelColor?.toDartUiColor() ?? Colors.black;
    final foregroundTextStyle = TextStyle(color: foregroundColor);
    final labelTextStyle = TextStyle(color: labelColor);

    return CouponTheme(
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
        color: foregroundColor,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      primaryTextStyle: TextStyle(
        color: foregroundColor,
        fontSize: 50,
        height: 0.9,
      ),
      auxiliaryLabelStyle: labelTextStyle.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      auxiliaryTextStyle: foregroundTextStyle.copyWith(
        fontSize: 18,
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

  final TextStyle primaryLabelStyle;
  final TextStyle primaryTextStyle;

  final TextStyle auxiliaryLabelStyle;
  final TextStyle auxiliaryTextStyle;

  @override
  ThemeExtension<CouponTheme> copyWith() => this;

  @override
  ThemeExtension<CouponTheme> lerp(
    covariant ThemeExtension<CouponTheme>? other,
    double t,
  ) =>
      this;
}
