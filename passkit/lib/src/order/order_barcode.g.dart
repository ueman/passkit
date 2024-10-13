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

Map<String, dynamic> _$OrderBarcodeToJson(OrderBarcode instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('altText', instance.altText);
  val['format'] = _$OrderBarcodeTypeEnumMap[instance.format]!;
  val['message'] = instance.message;
  val['messageEncoding'] = instance.messageEncoding;
  return val;
}

const _$OrderBarcodeTypeEnumMap = {
  OrderBarcodeType.qr: 'qr',
  OrderBarcodeType.pdf417: 'pdf417',
  OrderBarcodeType.aztec: 'aztec',
  OrderBarcodeType.code128: 'code128',
};
