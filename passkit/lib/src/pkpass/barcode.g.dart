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

Map<String, dynamic> _$BarcodeToJson(Barcode instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('altText', instance.altText);
  val['format'] = _$PkPassBarcodeTypeEnumMap[instance.format]!;
  val['message'] = instance.message;
  val['messageEncoding'] = instance.messageEncoding;
  return val;
}

const _$PkPassBarcodeTypeEnumMap = {
  PkPassBarcodeType.qr: 'PKBarcodeFormatQR',
  PkPassBarcodeType.pdf417: 'PKBarcodeFormatPDF417',
  PkPassBarcodeType.aztec: 'PKBarcodeFormatAztec',
  PkPassBarcodeType.code128: 'PKBarcodeFormatCode128',
};
