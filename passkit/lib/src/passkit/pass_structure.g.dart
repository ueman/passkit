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
      transitType: json['transitType'] as String?,
    );

Map<String, dynamic> _$PassStructureToJson(PassStructure instance) =>
    <String, dynamic>{
      'auxiliaryFields': instance.auxiliaryFields,
      'backFields': instance.backFields,
      'headerFields': instance.headerFields,
      'primaryFields': instance.primaryFields,
      'secondaryFields': instance.secondaryFields,
      'transitType': instance.transitType,
    };
