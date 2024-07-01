// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serial_numbers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerialNumbers _$SerialNumbersFromJson(Map<String, dynamic> json) =>
    SerialNumbers(
      serialNumbers: (json['serialNumbers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastUpdated: json['lastUpdated'] as String,
    );

Map<String, dynamic> _$SerialNumbersToJson(SerialNumbers instance) =>
    <String, dynamic>{
      'serialNumbers': instance.serialNumbers,
      'lastUpdated': instance.lastUpdated,
    };
