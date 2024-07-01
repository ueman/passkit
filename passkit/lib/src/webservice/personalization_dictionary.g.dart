// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalization_dictionary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalizationDictionary _$PersonalizationDictionaryFromJson(
        Map<String, dynamic> json) =>
    PersonalizationDictionary(
      personalizationToken: json['personalizationToken'] as String,
      requiredPersonalizationInfo:
          PersonalizationDictionaryRequiredPersonalizationInfo.fromJson(
              json['requiredPersonalizationInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PersonalizationDictionaryToJson(
        PersonalizationDictionary instance) =>
    <String, dynamic>{
      'personalizationToken': instance.personalizationToken,
      'requiredPersonalizationInfo': instance.requiredPersonalizationInfo,
    };

PersonalizationDictionaryRequiredPersonalizationInfo
    _$PersonalizationDictionaryRequiredPersonalizationInfoFromJson(
            Map<String, dynamic> json) =>
        PersonalizationDictionaryRequiredPersonalizationInfo(
          emailAddress: json['emailAddress'] as String?,
          familyName: json['familyName'] as String?,
          fullName: json['fullName'] as String?,
          givenName: json['givenName'] as String?,
          isoCountryCode: json['ISOCountryCode'] as String?,
          phoneNumber: json['phoneNumber'] as String?,
          postalCode: json['postalCode'] as String?,
        );

Map<String, dynamic>
    _$PersonalizationDictionaryRequiredPersonalizationInfoToJson(
            PersonalizationDictionaryRequiredPersonalizationInfo instance) =>
        <String, dynamic>{
          'emailAddress': instance.emailAddress,
          'familyName': instance.familyName,
          'fullName': instance.fullName,
          'givenName': instance.givenName,
          'ISOCountryCode': instance.isoCountryCode,
          'phoneNumber': instance.phoneNumber,
          'postalCode': instance.postalCode,
        };
