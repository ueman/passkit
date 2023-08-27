import 'package:json_annotation/json_annotation.dart';
import 'package:barcode/barcode.dart' as barcode;

part 'barcode.g.dart';

/// Information about a pass’s barcode.
@JsonSerializable()
class Barcode {
  Barcode({
    this.altText,
    required this.format,
    required this.message,
    required this.messageEncoding,
  });

  factory Barcode.fromJson(Map<String, dynamic> json) =>
      _$BarcodeFromJson(json);

  /// Optional. Text displayed near the barcode. For example, a human-readable
  /// version of the barcode data in case the barcode doesn’t scan.
  final String? altText;

  /// Required. Barcode format. For the barcode dictionary, you can use only the
  /// following values: PKBarcodeFormatQR, PKBarcodeFormatPDF417, or
  /// PKBarcodeFormatAztec. For dictionaries in the barcodes array, you may also
  /// use PKBarcodeFormatCode128.
  final String format;

  barcode.Barcode get formatType {
    if (format == 'PKBarcodeFormatQR') {
      return barcode.Barcode.qrCode(
        errorCorrectLevel: barcode.BarcodeQRCorrectionLevel.high,
      );
    }
    if (format == 'PKBarcodeFormatPDF417') {
      return barcode.Barcode.pdf417();
    }
    if (format == 'PKBarcodeFormatAztec') {
      return barcode.Barcode.aztec();
    }

    throw UnsupportedError('$format is not supported for barcodes in PKPASS');
  }

  /// Required. Message or payload to be displayed as a barcode.
  final String message;

  /// Required. Text encoding that is used to convert the message from the
  /// string representation to a data representation to render the barcode.
  /// The value is typically iso-8859-1, but you may use another encoding that
  /// is supported by your barcode scanning infrastructure.
  // IANA character set name, as a string
  final String messageEncoding;
}
