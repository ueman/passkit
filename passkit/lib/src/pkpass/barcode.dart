import 'package:json_annotation/json_annotation.dart';

part 'barcode.g.dart';

/// Information about a pass’s barcode.
@JsonSerializable(includeIfNull: false)
class Barcode implements ReadOnlyBarcode {
  Barcode({
    this.altText,
    required this.format,
    required this.message,
    required this.messageEncoding,
  });

  /// Creates an instance of [Barcode] from a JSON object
  factory Barcode.fromJson(Map<String, dynamic> json) =>
      _$BarcodeFromJson(json);

  /// Optional. Text displayed near the barcode. For example, a human-readable
  /// version of the barcode data in case the barcode doesn’t scan.
  @override
  @JsonKey(name: 'altText')
  String? altText;

  /// Required. Barcode format. For the barcode dictionary, you can use only the
  /// following values: PKBarcodeFormatQR, PKBarcodeFormatPDF417, or
  /// PKBarcodeFormatAztec. For dictionaries in the barcodes array, you may also
  /// use PKBarcodeFormatCode128.
  @override
  @JsonKey(name: 'format')
  PkPassBarcodeType format;

  /// Required. Message or payload to be displayed as a barcode.
  @override
  @JsonKey(name: 'message')
  String message;

  /// Required. Text encoding that is used to convert the message from the
  /// string representation to a data representation to render the barcode.
  /// The value is typically iso-8859-1, but you may use another encoding that
  /// is supported by your barcode scanning infrastructure.
  // IANA character set name, as a string
  @override
  @JsonKey(name: 'messageEncoding')
  String messageEncoding;

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$BarcodeToJson(this);

  Barcode copyWith({
    String? altText,
    PkPassBarcodeType? format,
    String? message,
    String? messageEncoding,
  }) {
    return Barcode(
      altText: altText ?? this.altText,
      format: format ?? this.format,
      message: message ?? this.message,
      messageEncoding: messageEncoding ?? this.messageEncoding,
    );
  }
}

enum PkPassBarcodeType {
  @JsonValue('PKBarcodeFormatQR')
  qr,

  @JsonValue('PKBarcodeFormatPDF417')
  pdf417,

  @JsonValue('PKBarcodeFormatAztec')
  aztec,

  @JsonValue('PKBarcodeFormatCode128')
  code128,
}

/// Readonly interface for barcode information.
abstract class ReadOnlyBarcode {
  /// Optional. Text displayed near the barcode.
  String? get altText;

  /// Required. Barcode format.
  PkPassBarcodeType get format;

  /// Required. Message or payload to be displayed as a barcode.
  String get message;

  /// Required. Text encoding that is used to convert the message.
  String get messageEncoding;
}
