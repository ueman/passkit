// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderApplication _$OrderApplicationFromJson(Map<String, dynamic> json) =>
    OrderApplication(
      customProductPageIdentifier:
          json['customProductPageIdentifier'] as String?,
      launchURL: json['launchURL'] as String?,
      storeIdentifier: json['storeIdentifier'] as num,
    );

Map<String, dynamic> _$OrderApplicationToJson(OrderApplication instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'customProductPageIdentifier', instance.customProductPageIdentifier);
  writeNotNull('launchURL', instance.launchURL);
  val['storeIdentifier'] = instance.storeIdentifier;
  return val;
}
