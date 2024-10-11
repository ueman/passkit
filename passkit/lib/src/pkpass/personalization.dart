import 'package:json_annotation/json_annotation.dart';

part 'personalization.g.dart';

/// Docs: https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/PassPersonalization.html#//apple_ref/doc/uid/TP40012195-CH12-SW2
@JsonSerializable()
class Personalization {
  Personalization({
    required this.description,
    required this.termsAndConditions,
    required this.requiredPersonalizationFields,
  });

  factory Personalization.fromJson(Map<String, dynamic> json) =>
      _$PersonalizationFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizationToJson(this);

  /// Required. A brief description of the program. This is displayed on the
  /// signup sheet, under the personalization logo.
  @JsonKey(name: 'description')
  final String description;

  /// Optional. A description of the program’s terms and conditions.
  /// This string can contain HTML link tags to external content.
  ///
  /// If present, this information is displayed after the user enters their
  /// personal information and taps the Next button. The user then has the
  /// option to agree to the terms, or to cancel out of the signup process.
  @JsonKey(name: 'termsAndConditions')
  final String? termsAndConditions;

  /// Required. The contents of this array define the data requested from the
  /// user. The signup form’s fields are generated based on these keys.
  @JsonKey(name: 'requiredPersonalizationFields')
  final List<RequiredPersonalizationFields> requiredPersonalizationFields;

  Personalization copyWith({
    String? description,
    String? termsAndConditions,
    List<RequiredPersonalizationFields>? requiredPersonalizationFields,
  }) {
    return Personalization(
      description: description ?? this.description,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      requiredPersonalizationFields:
          requiredPersonalizationFields ?? this.requiredPersonalizationFields,
    );
  }
}

enum RequiredPersonalizationFields {
  /// Prompts the user for their name. `fullName`, `givenName`, and `familyName`
  /// are submitted in the personalize request.
  @JsonValue('PKPassPersonalizationFieldName')
  name,

  /// Prompts the user for their postal code.
  /// `postalCode` and `ISOCountryCode` are submitted in the personalize request.
  @JsonValue('PKPassPersonalizationFieldPostalCode')
  postalCode,

  /// Prompts the user for their email address. `emailAddress` is submitted in the
  /// personalize request.
  @JsonValue('PKPassPersonalizationFieldEmailAddress')
  email,

  /// Prompts the user for their phone number.
  /// `phoneNumber` is submitted in the personalize request.
  @JsonValue('PKPassPersonalizationFieldPhoneNumber')
  phoneNumber
}
