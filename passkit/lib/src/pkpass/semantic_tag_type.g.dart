// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semantic_tag_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SemanticTagTypeWifiNetwork _$SemanticTagTypeWifiNetworkFromJson(
        Map<String, dynamic> json) =>
    SemanticTagTypeWifiNetwork(
      password: json['password'] as String,
      ssid: json['ssid'] as String,
    );

Map<String, dynamic> _$SemanticTagTypeWifiNetworkToJson(
        SemanticTagTypeWifiNetwork instance) =>
    <String, dynamic>{
      'password': instance.password,
      'ssid': instance.ssid,
    };

SemanticTagTypeCurrencyAmount _$SemanticTagTypeCurrencyAmountFromJson(
        Map<String, dynamic> json) =>
    SemanticTagTypeCurrencyAmount(
      amount: json['amount'] as String?,
      currencyCode: json['currencyCode'] as String?,
    );

Map<String, dynamic> _$SemanticTagTypeCurrencyAmountToJson(
    SemanticTagTypeCurrencyAmount instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('amount', instance.amount);
  writeNotNull('currencyCode', instance.currencyCode);
  return val;
}

SemanticTagTypeLocation _$SemanticTagTypeLocationFromJson(
        Map<String, dynamic> json) =>
    SemanticTagTypeLocation(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$SemanticTagTypeLocationToJson(
        SemanticTagTypeLocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

SemanticTagTypeSeat _$SemanticTagTypeSeatFromJson(Map<String, dynamic> json) =>
    SemanticTagTypeSeat(
      seatDescription: json['seatDescription'] as String?,
      seatIdentifier: json['seatIdentifier'] as String?,
      seatNumber: json['seatNumber'] as String?,
      seatRow: json['seatRow'] as String?,
      seatSection: json['seatSection'] as String?,
      seatType: json['seatType'] as String?,
    );

Map<String, dynamic> _$SemanticTagTypeSeatToJson(SemanticTagTypeSeat instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('seatDescription', instance.seatDescription);
  writeNotNull('seatIdentifier', instance.seatIdentifier);
  writeNotNull('seatNumber', instance.seatNumber);
  writeNotNull('seatRow', instance.seatRow);
  writeNotNull('seatSection', instance.seatSection);
  writeNotNull('seatType', instance.seatType);
  return val;
}

SemanticTagTypePersonNameComponents
    _$SemanticTagTypePersonNameComponentsFromJson(Map<String, dynamic> json) =>
        SemanticTagTypePersonNameComponents(
          familyName: json['familyName'] as String?,
          givenName: json['givenName'] as String?,
          middleName: json['middleName'] as String?,
          namePrefix: json['namePrefix'] as String?,
          nameSuffix: json['nameSuffix'] as String?,
          nickname: json['nickname'] as String?,
          phoneticRepresentation: json['phoneticRepresentation'] as String?,
        );

Map<String, dynamic> _$SemanticTagTypePersonNameComponentsToJson(
    SemanticTagTypePersonNameComponents instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('familyName', instance.familyName);
  writeNotNull('givenName', instance.givenName);
  writeNotNull('middleName', instance.middleName);
  writeNotNull('namePrefix', instance.namePrefix);
  writeNotNull('nameSuffix', instance.nameSuffix);
  writeNotNull('nickname', instance.nickname);
  writeNotNull('phoneticRepresentation', instance.phoneticRepresentation);
  return val;
}
