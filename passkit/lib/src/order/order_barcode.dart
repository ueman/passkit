import 'package:json_annotation/json_annotation.dart';

part 'order_barcode.g.dart';

/// Information about a pass’s barcode.
@JsonSerializable()
class OrderBarcode {
  OrderBarcode({
    this.altText,
    required this.format,
    required this.message,
    required this.messageEncoding,
  });

  /// Creates an instance of this class from a JSON object
  factory OrderBarcode.fromJson(Map<String, dynamic> json) =>
      _$OrderBarcodeFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$OrderBarcodeToJson(this);

  /// The localized text displayed by the barcode. For example, a human-readable
  /// version of the barcode data in case of a scanning failure.
  @JsonKey(name: 'altText')
  final String? altText;

  /// (Required) The format of the barcode.
  /// Possible Values: qr, pdf417, aztec, code128
  @JsonKey(name: 'format')
  final OrderBarcodeType format;

  /// The contents of the barcode.
  @JsonKey(name: 'message')
  final String message;

  /// Required. The text encoding of the barcode message. Typically this is
  /// iso-8859-1, but you may specify an alternative encoding if required.
  @JsonKey(name: 'messageEncoding')
  final String messageEncoding;
}

enum OrderBarcodeType {
  @JsonValue('qr')
  qr,

  @JsonValue('pdf417')
  pdf417,

  @JsonValue('aztec')
  aztec,

  @JsonValue('code128')
  code128,
}
