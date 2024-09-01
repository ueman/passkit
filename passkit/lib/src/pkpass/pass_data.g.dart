// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pass_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassData _$PassDataFromJson(Map<String, dynamic> json) => PassData(
      description: json['description'] as String,
      formatVersion: (json['formatVersion'] as num).toInt(),
      organizationName: json['organizationName'] as String,
      passTypeIdentifier: json['passTypeIdentifier'] as String,
      serialNumber: json['serialNumber'] as String,
      teamIdentifier: json['teamIdentifier'] as String,
      appLaunchURL: json['appLaunchURL'] as String?,
      associatedStoreIdentifiers:
          (json['associatedStoreIdentifiers'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList(),
      userInfo: json['userInfo'] as Map<String, dynamic>?,
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      voided: json['voided'] as bool?,
      beacons: (json['beacons'] as List<dynamic>?)
          ?.map((e) => Beacon.fromJson(e as Map<String, dynamic>))
          .toList(),
      locations: (json['locations'] as List<dynamic>?)
          ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
      maxDistance: json['maxDistance'] as num?,
      relevantDate: json['relevantDate'] == null
          ? null
          : DateTime.parse(json['relevantDate'] as String),
      boardingPass: json['boardingPass'] == null
          ? null
          : PassStructure.fromJson(
              json['boardingPass'] as Map<String, dynamic>),
      coupon: json['coupon'] == null
          ? null
          : PassStructure.fromJson(json['coupon'] as Map<String, dynamic>),
      eventTicket: json['eventTicket'] == null
          ? null
          : PassStructure.fromJson(json['eventTicket'] as Map<String, dynamic>),
      generic: json['generic'] == null
          ? null
          : PassStructure.fromJson(json['generic'] as Map<String, dynamic>),
      storeCard: json['storeCard'] == null
          ? null
          : PassStructure.fromJson(json['storeCard'] as Map<String, dynamic>),
      barcode: json['barcode'] == null
          ? null
          : Barcode.fromJson(json['barcode'] as Map<String, dynamic>),
      barcodes: (json['barcodes'] as List<dynamic>?)
          ?.map((e) => Barcode.fromJson(e as Map<String, dynamic>))
          .toList(),
      backgroundColor: parseColor(json['backgroundColor'] as String?),
      foregroundColor: parseColor(json['foregroundColor'] as String?),
      groupingIdentifier: json['groupingIdentifier'] as String?,
      labelColor: parseColor(json['labelColor'] as String?),
      logoText: json['logoText'] as String?,
      suppressStripShine: json['suppressStripShine'] as bool?,
      sharingProhibited: json['sharingProhibited'] as bool?,
      authenticationToken: json['authenticationToken'] as String?,
      webServiceURL: json['webServiceURL'] == null
          ? null
          : Uri.parse(json['webServiceURL'] as String),
      nfc: json['nfc'] == null
          ? null
          : Nfc.fromJson(json['nfc'] as Map<String, dynamic>),
      semantics: json['semantics'] == null
          ? null
          : Semantics.fromJson(json['semantics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PassDataToJson(PassData instance) {
  final val = <String, dynamic>{
    'description': instance.description,
    'formatVersion': instance.formatVersion,
    'organizationName': instance.organizationName,
    'passTypeIdentifier': instance.passTypeIdentifier,
    'serialNumber': instance.serialNumber,
    'teamIdentifier': instance.teamIdentifier,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('appLaunchURL', instance.appLaunchURL);
  writeNotNull(
      'associatedStoreIdentifiers', instance.associatedStoreIdentifiers);
  writeNotNull('userInfo', instance.userInfo);
  writeNotNull('expirationDate', instance.expirationDate?.toIso8601String());
  writeNotNull('voided', instance.voided);
  writeNotNull('beacons', instance.beacons);
  writeNotNull('locations', instance.locations);
  writeNotNull('maxDistance', instance.maxDistance);
  writeNotNull('relevantDate', instance.relevantDate?.toIso8601String());
  writeNotNull('boardingPass', instance.boardingPass);
  writeNotNull('coupon', instance.coupon);
  writeNotNull('eventTicket', instance.eventTicket);
  writeNotNull('generic', instance.generic);
  writeNotNull('storeCard', instance.storeCard);
  writeNotNull('barcode', instance.barcode);
  writeNotNull('barcodes', instance.barcodes);
  writeNotNull('backgroundColor', colorToString(instance.backgroundColor));
  writeNotNull('foregroundColor', colorToString(instance.foregroundColor));
  writeNotNull('groupingIdentifier', instance.groupingIdentifier);
  writeNotNull('labelColor', colorToString(instance.labelColor));
  writeNotNull('logoText', instance.logoText);
  writeNotNull('suppressStripShine', instance.suppressStripShine);
  writeNotNull('sharingProhibited', instance.sharingProhibited);
  writeNotNull('authenticationToken', instance.authenticationToken);
  writeNotNull('webServiceURL', instance.webServiceURL?.toString());
  writeNotNull('nfc', instance.nfc);
  writeNotNull('semantics', instance.semantics);
  return val;
}
