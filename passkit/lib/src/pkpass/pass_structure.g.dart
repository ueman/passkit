// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pass_structure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassStructure _$PassStructureFromJson(Map<String, dynamic> json) =>
    PassStructure(
      auxiliaryFields: (json['auxiliaryFields'] as List<dynamic>?)
          ?.map((e) => FieldDict.fromJson(e as Map<String, dynamic>))
          .toList(),
      backFields: (json['backFields'] as List<dynamic>?)
          ?.map((e) => FieldDict.fromJson(e as Map<String, dynamic>))
          .toList(),
      headerFields: (json['headerFields'] as List<dynamic>?)
          ?.map((e) => FieldDict.fromJson(e as Map<String, dynamic>))
          .toList(),
      primaryFields: (json['primaryFields'] as List<dynamic>?)
          ?.map((e) => FieldDict.fromJson(e as Map<String, dynamic>))
          .toList(),
      secondaryFields: (json['secondaryFields'] as List<dynamic>?)
          ?.map((e) => FieldDict.fromJson(e as Map<String, dynamic>))
          .toList(),
      transitType:
          $enumDecodeNullable(_$TransitTypeEnumMap, json['transitType']) ??
              TransitType.generic,
    );

Map<String, dynamic> _$PassStructureToJson(PassStructure instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('auxiliaryFields', instance.auxiliaryFields);
  writeNotNull('backFields', instance.backFields);
  writeNotNull('headerFields', instance.headerFields);
  writeNotNull('primaryFields', instance.primaryFields);
  writeNotNull('secondaryFields', instance.secondaryFields);
  val['transitType'] = _$TransitTypeEnumMap[instance.transitType]!;
  return val;
}

const _$TransitTypeEnumMap = {
  TransitType.air: 'PKTransitTypeAir',
  TransitType.boat: 'PKTransitTypeBoat',
  TransitType.bus: 'PKTransitTypeBus',
  TransitType.generic: 'PKTransitTypeGeneric',
  TransitType.train: 'PKTransitTypeTrain',
};
