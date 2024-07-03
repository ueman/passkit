import 'package:json_annotation/json_annotation.dart';
import 'package:passkit/src/passkit/semantics.dart';

part 'field_dict.g.dart';

@JsonSerializable()
class FieldDict {
  factory FieldDict.fromJson(Map<String, dynamic> json) =>
      _$FieldDictFromJson(json);

  FieldDict({
    this.attributedValue,
    this.changeMessage,
    this.dataDetectorTypes,
    required this.key,
    this.label,
    this.textAlignment,
    required this.value,
    this.currencyCode,
    this.dateStyle,
    this.timeStyle,
    this.numberStyle,
    this.ignoresTimeZone,
    this.isRelative,
    this.semantics,
    this.row,
  }) : assert(
          row == null || row == 0 || row == 1,
          'Allowed values for row are null, 0 and 1',
        );

  /// Optional. Attributed value of the field.
  /// The value may contain HTML markup for links. Only the <a> tag and its href
  /// attribute are supported. For example, the following is key-value pair
  /// specifies a link with the text “Edit my profile”:
  /// "attributedValue": "<a href='http://example.com/customers/123'>Edit my profile</a>"
  /// This key’s value overrides the text specified by the value key.
  /// Available in iOS 7.0.
  // localizable string, ISO 8601 date as a string, or number
  final String? attributedValue;

  /// Optional. Format string for the alert text that is displayed when the pass
  /// is updated. The format string must contain the escape %@, which is
  /// replaced with the field’s new value. For example, “Gate changed to %@.”
  /// If you don’t specify a change message, the user isn’t notified when the
  /// field changes.
  // localizable format string
  final String? changeMessage;

  /// Optional. Data detectors that are applied to the field’s value.
  /// Valid values are:
  ///
  /// - [DataDetectorTypes.phoneNumber]
  /// - [DataDetectorTypes.link]
  /// - [DataDetectorTypes.typeAddress]
  /// - [DataDetectorTypes.calendarEvent]
  /// - The default value is all data detectors. Provide an empty array to use
  ///   no data detectors.
  ///
  /// Data detectors are applied only to back fields.
  final List<DataDetectorTypes>? dataDetectorTypes;

  /// Required. The key must be unique within the scope of the entire pass.
  /// For example, “departure-gate.”
  final String key;

  /// Optional. Label text for the field.
  // localizable string
  final String? label;

  /// Optional. Alignment for the field’s contents.
  /// Must be one of the following values:
  ///
  /// - [PkTextAlignment.left]
  /// - [PkTextAlignment.center]
  /// - [PkTextAlignment.right]
  /// - [PkTextAlignment.natural]
  ///
  /// The default value is natural alignment, which aligns the text
  /// appropriately based on its script direction.
  ///
  /// This key is not allowed for primary fields or back fields.
  final PkTextAlignment? textAlignment;

  /// Required. Value of the field, for example, 42.
  /// This can contain a localizable string, ISO 8601 date as a string,
  /// or a number (double/int)
  final Object? value;

  /// The currency code to use for the value of the field.
  /// ISO 4217 currency code as a string
  final String? currencyCode;

  /// The style of the date to display in the field.
  final DateStyle? dateStyle;

  /// The style of the time displayed in the field.
  final DateStyle? timeStyle;

  /// The style of the number to display in the field. Formatter styles have the same meaning as the formats with corresponding names in NumberFormatter.Style.
  /// Possible Values: PKNumberStyleDecimal, PKNumberStylePercent, PKNumberStyleScientific, PKNumberStyleSpellOut
  final NumberStyle? numberStyle;

  /// A Boolean value that controls the time zone for the time and date to
  /// display in the field. The default value is false, which displays the time
  /// and date using the current device’s time zone. Otherwise, the time and
  /// date appear in the time zone associated with the date and time of value.
  ///
  /// This key doesn’t affect the pass relevance calculation.
  final bool? ignoresTimeZone;

  /// A Boolean value that controls whether the date appears as a relative date.
  /// The default value is false, which displays the date as an absolute date.
  ///
  /// This key doesn’t affect the pass relevance calculation.
  final bool? isRelative;

  /// You can augment the user-visible information on Wallet passes with
  /// machine-readable metadata known as semantic tags. The metadata in semantic
  /// tags helps the system better understand Wallet passes and suggest relevant
  /// actions for the user to take on their installed passes.
  ///
  /// An object that contains machine-readable metadata the system uses to offer
  /// a pass and suggest related actions.
  final Semantics? semantics;

  /// A number you use to add a row to the auxiliary field in an event ticket
  /// pass type. Set the value to 1 to add an auxiliary row.
  /// Each row displays up to four fields.
  ///
  /// Possible Values: 0, 1
  /// This field is only valid for event pass types.
  final int? row;
}

enum PkTextAlignment {
  /// Text should be left aligned
  @JsonValue('PKTextAlignmentLeft')
  left,

  /// Text should be center aligned
  @JsonValue('PKTextAlignmentCenter')
  center,

  /// Text should be right aligned
  @JsonValue('PKTextAlignmentRight')
  right,

  /// The default alignment for left-to-right scripts is left, and the default
  /// alignment for right-to-left scripts is right.
  @JsonValue('PKTextAlignmentNatural')
  natural,
}

enum DataDetectorTypes {
  /// Indicates the value is a phone number
  @JsonValue('PKDataDetectorTypePhoneNumber')
  phoneNumber,

  /// Indicates the value is a link number
  @JsonValue('PKDataDetectorTypeLink')
  link,

  /// Indicates the value is an address
  @JsonValue('PKDataDetectorTypeAddress')
  typeAddress,

  /// Indicates the value is a calendar event
  @JsonValue('PKDataDetectorTypeCalendarEvent')
  calendarEvent,
}

enum DateStyle {
  @JsonValue('PKDateStyleNone')
  none,

  @JsonValue('PKDateStyleShort')
  short,

  @JsonValue('PKDateStyleMedium')
  medium,

  @JsonValue('PKDateStyleLong')
  long,

  @JsonValue('PKDateStyleFull')
  full,
}

/// https://developer.apple.com/documentation/foundation/numberformatter/style
enum NumberStyle {
  @JsonValue('PKNumberStyleDecimal')
  decimal,

  @JsonValue('PKNumberStylePercent')
  percent,

  @JsonValue('PKNumberStyleScientific')
  scientific,

  @JsonValue('PKNumberStyleSpellOut')
  spellOut,
}
