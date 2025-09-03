// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semantic_tag_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SemanticTagTypeWifiNetwork _$SemanticTagTypeWifiNetworkFromJson(
  Map<String, dynamic> json,
) => SemanticTagTypeWifiNetwork(
  password: json['password'] as String,
  ssid: json['ssid'] as String,
);

Map<String, dynamic> _$SemanticTagTypeWifiNetworkToJson(
  SemanticTagTypeWifiNetwork instance,
) => <String, dynamic>{'password': instance.password, 'ssid': instance.ssid};

SemanticTagTypeCurrencyAmount _$SemanticTagTypeCurrencyAmountFromJson(
  Map<String, dynamic> json,
) => SemanticTagTypeCurrencyAmount(
  amount: json['amount'] as String?,
  currencyCode: json['currencyCode'] as String?,
);

Map<String, dynamic> _$SemanticTagTypeCurrencyAmountToJson(
  SemanticTagTypeCurrencyAmount instance,
) => <String, dynamic>{
  'amount': ?instance.amount,
  'currencyCode': ?instance.currencyCode,
};

SemanticTagTypeLocation _$SemanticTagTypeLocationFromJson(
  Map<String, dynamic> json,
) => SemanticTagTypeLocation(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$SemanticTagTypeLocationToJson(
  SemanticTagTypeLocation instance,
) => <String, dynamic>{
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

Map<String, dynamic> _$SemanticTagTypeSeatToJson(
  SemanticTagTypeSeat instance,
) => <String, dynamic>{
  'seatDescription': ?instance.seatDescription,
  'seatIdentifier': ?instance.seatIdentifier,
  'seatNumber': ?instance.seatNumber,
  'seatRow': ?instance.seatRow,
  'seatSection': ?instance.seatSection,
  'seatType': ?instance.seatType,
};

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
  SemanticTagTypePersonNameComponents instance,
) => <String, dynamic>{
  'familyName': ?instance.familyName,
  'givenName': ?instance.givenName,
  'middleName': ?instance.middleName,
  'namePrefix': ?instance.namePrefix,
  'nameSuffix': ?instance.nameSuffix,
  'nickname': ?instance.nickname,
  'phoneticRepresentation': ?instance.phoneticRepresentation,
};
