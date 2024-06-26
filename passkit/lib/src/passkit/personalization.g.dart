// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Personalization _$PersonalizationFromJson(Map<String, dynamic> json) =>
    Personalization(
      description: json['description'] as String,
      termsAndConditions: json['termsAndConditions'] as String?,
      requiredPersonalizationFields: (json['requiredPersonalizationFields']
              as List<dynamic>)
          .map((e) => $enumDecode(_$RequiredPersonalizationFieldsEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$PersonalizationToJson(Personalization instance) =>
    <String, dynamic>{
      'description': instance.description,
      'termsAndConditions': instance.termsAndConditions,
      'requiredPersonalizationFields': instance.requiredPersonalizationFields
          .map((e) => _$RequiredPersonalizationFieldsEnumMap[e]!)
          .toList(),
    };

const _$RequiredPersonalizationFieldsEnumMap = {
  RequiredPersonalizationFields.name: 'PKPassPersonalizationFieldName',
  RequiredPersonalizationFields.postalCode:
      'PKPassPersonalizationFieldPostalCode',
  RequiredPersonalizationFields.email: 'PKPassPersonalizationFieldEmailAddress',
  RequiredPersonalizationFields.phoneNumber:
      'PKPassPersonalizationFieldPhoneNumber',
};
