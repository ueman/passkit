// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_barcode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderBarcode _$OrderBarcodeFromJson(Map<String, dynamic> json) => OrderBarcode(
      altText: json['altText'] as String?,
      format: json['format'] as String,
      message: json['message'] as String,
      messageEncoding: json['messageEncoding'] as String,
    );

Map<String, dynamic> _$OrderBarcodeToJson(OrderBarcode instance) =>
    <String, dynamic>{
      'altText': instance.altText,
      'format': instance.format,
      'message': instance.message,
      'messageEncoding': instance.messageEncoding,
    };
