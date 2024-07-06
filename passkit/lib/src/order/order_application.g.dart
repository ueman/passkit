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

Map<String, dynamic> _$OrderApplicationToJson(OrderApplication instance) =>
    <String, dynamic>{
      'customProductPageIdentifier': instance.customProductPageIdentifier,
      'launchURL': instance.launchURL,
      'storeIdentifier': instance.storeIdentifier,
    };
