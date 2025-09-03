// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_barcode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderBarcode _$OrderBarcodeFromJson(Map<String, dynamic> json) => OrderBarcode(
  altText: json['altText'] as String?,
  format: $enumDecode(_$OrderBarcodeTypeEnumMap, json['format']),
  message: json['message'] as String,
  messageEncoding: json['messageEncoding'] as String,
);

Map<String, dynamic> _$OrderBarcodeToJson(OrderBarcode instance) =>
    <String, dynamic>{
      'altText': ?instance.altText,
      'format': _$OrderBarcodeTypeEnumMap[instance.format]!,
      'message': instance.message,
      'messageEncoding': instance.messageEncoding,
    };

const _$OrderBarcodeTypeEnumMap = {
  OrderBarcodeType.qr: 'qr',
  OrderBarcodeType.pdf417: 'pdf417',
  OrderBarcodeType.aztec: 'aztec',
  OrderBarcodeType.code128: 'code128',
};
