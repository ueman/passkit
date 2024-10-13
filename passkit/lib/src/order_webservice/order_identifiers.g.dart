// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_identifiers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderIdentifiers _$OrderIdentifiersFromJson(Map<String, dynamic> json) =>
    OrderIdentifiers(
      orderIdentifiers: (json['orderIdentifiers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastUpdated: json['lastUpdated'] as String,
    );

Map<String, dynamic> _$OrderIdentifiersToJson(OrderIdentifiers instance) =>
    <String, dynamic>{
      'orderIdentifiers': instance.orderIdentifiers,
      'lastUpdated': instance.lastUpdated,
    };
