// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderAddress _$OrderAddressFromJson(Map<String, dynamic> json) => OrderAddress(
  addressLines: (json['addressLines'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  administrativeArea: json['administrativeArea'] as String?,
  countryCode: json['countryCode'] as String?,
  locality: json['locality'] as String?,
  postalCode: json['postalCode'] as String?,
  subAdministrativeArea: json['subAdministrativeArea'] as String?,
  subLocality: json['subLocality'] as String?,
);

Map<String, dynamic> _$OrderAddressToJson(OrderAddress instance) =>
    <String, dynamic>{
      'addressLines': ?instance.addressLines,
      'administrativeArea': ?instance.administrativeArea,
      'countryCode': ?instance.countryCode,
      'locality': ?instance.locality,
      'postalCode': ?instance.postalCode,
      'subAdministrativeArea': ?instance.subAdministrativeArea,
      'subLocality': ?instance.subLocality,
    };
