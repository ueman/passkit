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

Map<String, dynamic> _$OrderAddressToJson(OrderAddress instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('addressLines', instance.addressLines);
  writeNotNull('administrativeArea', instance.administrativeArea);
  writeNotNull('countryCode', instance.countryCode);
  writeNotNull('locality', instance.locality);
  writeNotNull('postalCode', instance.postalCode);
  writeNotNull('subAdministrativeArea', instance.subAdministrativeArea);
  writeNotNull('subLocality', instance.subLocality);
  return val;
}
