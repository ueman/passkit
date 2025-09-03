import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/theme/base_pass_theme.dart';

/// ThemeExtension for a event ticket.
///
/// ![](https://docs-assets.developer.apple.com/published/a0a42a2d3a332050cdcaba0eefa6d0ec/event-ticket@2x.png)
/// ![](https://docs-assets.developer.apple.com/published/b43416bbcd92dc2d60485a97d1d94bda/event-ticket-layout-1@2x.png)
/// ![](https://docs-assets.developer.apple.com/published/428687f3fc4317c43ecd549547d7606f/event-ticket-layout-2@2x.png)
///
/// See:
/// - https://developer.apple.com/design/human-interface-guidelines/wallet#Event-tickets
class EventTicketTheme extends ThemeExtension<EventTicketTheme>
    implements BasePassTheme {
  EventTicketTheme({
    required this.auxiliaryLabelStyle,
    required this.auxiliaryTextStyle,
    required this.headerLabelStyle,
    required this.headerTextStyle,
    required this.primaryWithStripLabelStyle,
    required this.primaryWithStripTextStyle,
    required this.primaryWithThumbnailLabelStyle,
    required this.primaryWithThumbnailTextStyle,
    required this.secondaryWithStripLabelStyle,
    required this.secondaryWithStripTextStyle,
    required this.secondaryWithThumbnailLabelStyle,
    required this.secondaryWithThumbnailTextStyle,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.labelColor,
    required this.logoTextStyle,
  });

  factory EventTicketTheme.fromPass(ReadOnlyPkPass pass) {
    final backgroundColor =
        pass.pass.backgroundColor?.toDartUiColor() ?? Colors.white;
    final foregroundColor =
        pass.pass.foregroundColor?.toDartUiColor() ?? Colors.black;
    final labelColor = pass.pass.labelColor?.toDartUiColor() ?? Colors.black;
    final foregroundTextStyle = TextStyle(color: foregroundColor);
    final labelTextStyle = TextStyle(color: labelColor);

    return EventTicketTheme(
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
      primaryWithStripLabelStyle: labelTextStyle.copyWith(
        color: foregroundColor,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      primaryWithStripTextStyle: foregroundTextStyle.copyWith(
        color: foregroundColor,
        fontSize: 50,
        height: 0.9,
      ),
      secondaryWithStripLabelStyle: labelTextStyle.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      secondaryWithStripTextStyle: foregroundTextStyle.copyWith(
        fontSize: 12,
        height: 0.9,
      ),
      primaryWithThumbnailLabelStyle: labelTextStyle.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      primaryWithThumbnailTextStyle: foregroundTextStyle.copyWith(
        color: foregroundColor,
        fontSize: 16,
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

  final TextStyle primaryWithStripLabelStyle;
  final TextStyle primaryWithStripTextStyle;

  final TextStyle primaryWithThumbnailLabelStyle;
  final TextStyle primaryWithThumbnailTextStyle;

  final TextStyle secondaryWithStripLabelStyle;
  final TextStyle secondaryWithStripTextStyle;

  final TextStyle secondaryWithThumbnailLabelStyle;
  final TextStyle secondaryWithThumbnailTextStyle;

  final TextStyle auxiliaryLabelStyle;
  final TextStyle auxiliaryTextStyle;

  @override
  ThemeExtension<EventTicketTheme> copyWith() => this;

  @override
  ThemeExtension<EventTicketTheme> lerp(
    covariant ThemeExtension<EventTicketTheme>? other,
    double t,
  ) =>
      this;
}
