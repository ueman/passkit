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
      value: json['value'],
      currencyCode: json['currencyCode'] as String?,
      dateStyle: $enumDecodeNullable(_$DateStyleEnumMap, json['dateStyle']),
      timeStyle: $enumDecodeNullable(_$DateStyleEnumMap, json['timeStyle']),
      numberStyle:
          $enumDecodeNullable(_$NumberStyleEnumMap, json['numberStyle']),
      ignoresTimeZone: json['ignoresTimeZone'] as bool?,
      isRelative: json['isRelative'] as bool?,
      semantics: json['semantics'] == null
          ? null
          : Semantics.fromJson(json['semantics'] as Map<String, dynamic>),
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
      'currencyCode': instance.currencyCode,
      'dateStyle': _$DateStyleEnumMap[instance.dateStyle],
      'timeStyle': _$DateStyleEnumMap[instance.timeStyle],
      'numberStyle': _$NumberStyleEnumMap[instance.numberStyle],
      'ignoresTimeZone': instance.ignoresTimeZone,
      'isRelative': instance.isRelative,
      'semantics': instance.semantics,
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

const _$DateStyleEnumMap = {
  DateStyle.none: 'PKDateStyleNone',
  DateStyle.short: 'PKDateStyleShort',
  DateStyle.medium: 'PKDateStyleMedium',
  DateStyle.long: 'PKDateStyleLong',
  DateStyle.full: 'PKDateStyleFull',
};

const _$NumberStyleEnumMap = {
  NumberStyle.decimal: 'PKNumberStyleDecimal',
  NumberStyle.percent: 'PKNumberStylePercent',
  NumberStyle.scientific: 'PKNumberStyleScientific',
  NumberStyle.spellOut: 'PKNumberStyleSpellOut',
};
