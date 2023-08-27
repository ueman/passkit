// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_dict.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldDict _$FieldDictFromJson(Map<String, dynamic> json) => FieldDict(
      attributedValue: json['attributedValue'] as String?,
      changeMessage: json['changeMessage'] as String?,
      dataDetectorTypes: (json['dataDetectorTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      key: json['key'] as String,
      label: json['label'] as String?,
      textAlignment: json['textAlignment'] as String?,
      value: json['value'] as String,
    );

Map<String, dynamic> _$FieldDictToJson(FieldDict instance) => <String, dynamic>{
      'attributedValue': instance.attributedValue,
      'changeMessage': instance.changeMessage,
      'dataDetectorTypes': instance.dataDetectorTypes,
      'key': instance.key,
      'label': instance.label,
      'textAlignment': instance.textAlignment,
      'value': instance.value,
    };
