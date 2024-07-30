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
      textAlignment: $enumDecodeNullable(
              _$PkTextAlignmentEnumMap, json['textAlignment']) ??
          PkTextAlignment.natural,
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
      row: (json['row'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FieldDictToJson(FieldDict instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('attributedValue', instance.attributedValue);
  writeNotNull('changeMessage', instance.changeMessage);
  writeNotNull(
      'dataDetectorTypes',
      instance.dataDetectorTypes
          ?.map((e) => _$DataDetectorTypesEnumMap[e]!)
          .toList());
  val['key'] = instance.key;
  writeNotNull('label', instance.label);
  val['textAlignment'] = _$PkTextAlignmentEnumMap[instance.textAlignment]!;
  writeNotNull('value', instance.value);
  writeNotNull('currencyCode', instance.currencyCode);
  writeNotNull('dateStyle', _$DateStyleEnumMap[instance.dateStyle]);
  writeNotNull('timeStyle', _$DateStyleEnumMap[instance.timeStyle]);
  writeNotNull('numberStyle', _$NumberStyleEnumMap[instance.numberStyle]);
  writeNotNull('ignoresTimeZone', instance.ignoresTimeZone);
  writeNotNull('isRelative', instance.isRelative);
  writeNotNull('semantics', instance.semantics);
  writeNotNull('row', instance.row);
  return val;
}

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
