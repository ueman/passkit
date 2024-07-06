// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderLocation _$OrderLocationFromJson(Map<String, dynamic> json) =>
    OrderLocation(
      altitude: json['altitude'] as num?,
      latitude: json['latitude'] as num,
      longitude: json['longitude'] as num,
    );

Map<String, dynamic> _$OrderLocationToJson(OrderLocation instance) =>
    <String, dynamic>{
      'altitude': instance.altitude,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
