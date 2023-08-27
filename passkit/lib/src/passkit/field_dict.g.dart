// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_dict.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldDict _$FieldDictFromJson(Map<String, dynamic> json) => FieldDict(
      attributedValue: json['attributedValue'] as String?,
      changeMessage: json['changeMessage'] as String?,
      dataDetectorTypes: (json['dataDetectorTypes'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$DataDetectorTypesEnumMap, e))
          .toList(),
      key: json['key'] as String,
      label: json['label'] as String?,
      textAlignment:
          $enumDecodeNullable(_$PkTextAlignmentEnumMap, json['textAlignment']),
      value: json['value'] as String,
    );

Map<String, dynamic> _$FieldDictToJson(FieldDict instance) => <String, dynamic>{
      'attributedValue': instance.attributedValue,
      'changeMessage': instance.changeMessage,
      'dataDetectorTypes': instance.dataDetectorTypes
          ?.map((e) => _$DataDetectorTypesEnumMap[e]!)
          .toList(),
      'key': instance.key,
      'label': instance.label,
      'textAlignment': _$PkTextAlignmentEnumMap[instance.textAlignment],
      'value': instance.value,
    };

const _$DataDetectorTypesEnumMap = {
  DataDetectorTypes.phoneNumber: 'PKDataDetectorTypePhoneNumber',
  DataDetectorTypes.link: 'PKDataDetectorTypeLink',
  DataDetectorTypes.typeAddress: 'PKDataDetectorTypeAddress',
  DataDetectorTypes.calendarEvent: 'PKDataDetectorTypeCalendarEvent',
};

const _$PkTextAlignmentEnumMap = {
  PkTextAlignment.left: 'PKTextAlignmentLeft',
  PkTextAlignment.center: 'PKTextAlignmentCenter',
  PkTextAlignment.right: 'PKTextAlignmentRight',
  PkTextAlignment.natural: 'PKTextAlignmentNatural',
};
