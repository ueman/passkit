// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Barcode _$BarcodeFromJson(Map<String, dynamic> json) => Barcode(
  altText: json['altText'] as String?,
  format: $enumDecode(_$PkPassBarcodeTypeEnumMap, json['format']),
  message: json['message'] as String,
  messageEncoding: json['messageEncoding'] as String,
);

Map<String, dynamic> _$BarcodeToJson(Barcode instance) => <String, dynamic>{
  'altText': ?instance.altText,
  'format': _$PkPassBarcodeTypeEnumMap[instance.format]!,
  'message': instance.message,
  'messageEncoding': instance.messageEncoding,
};

const _$PkPassBarcodeTypeEnumMap = {
  PkPassBarcodeType.qr: 'PKBarcodeFormatQR',
  PkPassBarcodeType.pdf417: 'PKBarcodeFormatPDF417',
  PkPassBarcodeType.aztec: 'PKBarcodeFormatAztec',
  PkPassBarcodeType.code128: 'PKBarcodeFormatCode128',
};
