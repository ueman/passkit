// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beacon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Beacon _$BeaconFromJson(Map<String, dynamic> json) => Beacon(
      major: (json['major'] as num?)?.toInt(),
      minor: (json['minor'] as num?)?.toInt(),
      proximityUUID: json['proximityUUID'] as String,
      relevantText: json['relevantText'] as String?,
    );

Map<String, dynamic> _$BeaconToJson(Beacon instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('major', instance.major);
  writeNotNull('minor', instance.minor);
  val['proximityUUID'] = instance.proximityUUID;
  writeNotNull('relevantText', instance.relevantText);
  return val;
}
