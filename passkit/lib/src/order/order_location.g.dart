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

Map<String, dynamic> _$OrderLocationToJson(OrderLocation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('altitude', instance.altitude);
  val['latitude'] = instance.latitude;
  val['longitude'] = instance.longitude;
  return val;
}
