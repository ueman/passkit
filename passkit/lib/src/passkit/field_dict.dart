import 'package:json_annotation/json_annotation.dart';

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
  });

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
  /// - PKDataDetectorTypePhoneNumber
  /// - PKDataDetectorTypeLink
  /// - PKDataDetectorTypeAddress
  /// - PKDataDetectorTypeCalendarEvent
  /// - The default value is all data detectors. Provide an empty array to use
  ///   no data detectors.
  ///
  /// Data detectors are applied only to back fields.
  // array of strings
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
  /// - PKTextAlignmentLeft
  /// - PKTextAlignmentCenter
  /// - PKTextAlignmentRight
  /// - PKTextAlignmentNatural
  ///
  /// The default value is natural alignment, which aligns the text
  /// appropriately based on its script direction.
  ///
  /// This key is not allowed for primary fields or back fields.
  final PkTextAlignment? textAlignment;

  /// Required. Value of the field, for example, 42.
  // localizable string, ISO 8601 date as a string, or number
  final String value;
}

enum PkTextAlignment {
  @JsonValue('PKTextAlignmentLeft')
  left,
  @JsonValue('PKTextAlignmentCenter')
  center,
  @JsonValue('PKTextAlignmentRight')
  right,
  @JsonValue('PKTextAlignmentNatural')
  natural,
}

enum DataDetectorTypes {
  @JsonValue('PKDataDetectorTypePhoneNumber')
  phoneNumber,
  @JsonValue('PKDataDetectorTypeLink')
  link,
  @JsonValue('PKDataDetectorTypeAddress')
  typeAddress,
  @JsonValue('PKDataDetectorTypeCalendarEvent')
  calendarEvent,
}
