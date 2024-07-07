// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      altitude: (json['altitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      relevantText: json['relevantText'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'altitude': instance.altitude,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'relevantText': instance.relevantText,
    };
