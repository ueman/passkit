import 'package:json_annotation/json_annotation.dart';

part 'personalization_dictionary.g.dart';

/// PersonalizationDictionary
/// An object that contains the information you use to personalize a pass.
/// Docs:
/// https://developer.apple.com/documentation/walletpasses/personalizationdictionary
@JsonSerializable()
class PersonalizationDictionary {
  PersonalizationDictionary({
    required this.personalizationToken,
    required this.requiredPersonalizationInfo,
  });

  factory PersonalizationDictionary.fromJson(Map<String, dynamic> json) =>
      _$PersonalizationDictionaryFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizationDictionaryToJson(this);

  /// The personalization token for this request. The server must sign and
  /// return the token.
  @JsonKey(name: 'personalizationToken')
  final String personalizationToken;

  @JsonKey(name: 'requiredPersonalizationInfo')
  final PersonalizationDictionaryRequiredPersonalizationInfo
      requiredPersonalizationInfo;
}

/// An object that contains the user-entered information for a personalized pass.
@JsonSerializable()
class PersonalizationDictionaryRequiredPersonalizationInfo {
  PersonalizationDictionaryRequiredPersonalizationInfo({
    required this.emailAddress,
    required this.familyName,
    required this.fullName,
    required this.givenName,
    required this.isoCountryCode,
    required this.phoneNumber,
    required this.postalCode,
  });

  factory PersonalizationDictionaryRequiredPersonalizationInfo.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PersonalizationDictionaryRequiredPersonalizationInfoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PersonalizationDictionaryRequiredPersonalizationInfoToJson(this);

  /// The user-entered email address for the user of the personalized pass.
  @JsonKey(name: 'emailAddress')
  final String? emailAddress;

  /// The family name for the user of the personalized pass, parsed from the full name. The name can indicate membership in a group.
  @JsonKey(name: 'familyName')
  final String? familyName;

  /// The user-entered full name for the user of the personalized pass.
  @JsonKey(name: 'fullName')
  final String? fullName;

  /// The given name for the user of the personalized pass, parsed from the full name. The system uses the name to differentiate the individual from other members who share the same family name. In some locales, the given name is also known as a forename or first name.
  @JsonKey(name: 'givenName')
  final String? givenName;

  /// The ISO country code. The system sets this key when it’s known; otherwise, it doesn’t include the key.
  @JsonKey(name: 'ISOCountryCode')
  final String? isoCountryCode;

  /// The user-entered phone number for the user of the personalized pass.
  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;

  /// The user-entered postal code for the user of the personalized pass.
  @JsonKey(name: 'postalCode')
  final String? postalCode;
}
