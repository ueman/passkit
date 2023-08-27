// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beacon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Beacon _$BeaconFromJson(Map<String, dynamic> json) => Beacon(
      major: json['major'] as int?,
      minor: json['minor'] as int?,
      proximityUUID: json['proximityUUID'] as String,
      relevantText: json['relevantText'] as String?,
    );

Map<String, dynamic> _$BeaconToJson(Beacon instance) => <String, dynamic>{
      'major': instance.major,
      'minor': instance.minor,
      'proximityUUID': instance.proximityUUID,
      'relevantText': instance.relevantText,
    };
