import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:passkit/src/archive_extensions.dart';
import 'package:passkit/src/pkpass/exceptions.dart';
import 'package:passkit/src/signature_verification.dart';

import 'order_data.dart';

class PkOrder {
  PkOrder({
    required this.order,
    required this.manifest,
    required this.sourceData,
    this.languageData,
  });

  /// Parses bytes to a [PkOrder] instance.
  /// Setting [skipVerification] to true disables any checksum or signature
  /// verification and validation.
  // TODO(ueman): Provide an async method for this.
  static PkOrder fromBytes(
    final List<int> bytes, {
    bool skipChecksumVerification = false,
    bool skipSignatureVerification = false,
  }) {
    if (bytes.isEmpty) {
      throw EmptyBytesException();
    }

    ZipDecoder decoder = ZipDecoder();
    final archive = decoder.decodeBytes(bytes);

    final manifest = archive.readManifest();
    final order = archive.readOrder();
    if (!skipChecksumVerification) {
      archive.checkSha1Checksums(manifest);

      if (skipSignatureVerification) {
        final manifestContent =
            archive.findFile('manifest.json')!.content as List<int>;
        final signatureContent = Uint8List.fromList(
          archive.findFile('signature')!.content as List<int>,
        );

        verifySignature(
          signatureBytes: signatureContent,
          manifestBytes: manifestContent,
          identifier: order.orderTypeIdentifier,
          teamIdentifier: order.merchant.merchantIdentifier,
        );
      }
    }

    return PkOrder(
      // data
      order: order,
      manifest: manifest,
      languageData: archive.getTranslations(),
      // source
      sourceData: bytes,
    );
  }

  final OrderData order;

  /// Mapping of files to their respective checksums. Typically not relevant for
  /// users of this package.
  final Map<String, dynamic> manifest;

  /// List of available languages. Each value is a language identifier
  Iterable<String> get availableLanguages => languageData?.keys ?? [];

  /// Translations for this PkPass.
  /// Consists of a mapping of language identifier to translation key-value
  /// pairs.
  final Map<String, Map<String, dynamic>>? languageData;

  /// The bytes of this PkPass
  final List<int> sourceData;

  /// Indicates whether a webservices is available.
  bool get isWebServiceAvailable => order.webServiceURL != null;
}

extension on Archive {
  OrderData readOrder() {
    final passJson = findFileAndReadAsJson('order.json');
    if (passJson != null) {
      return OrderData.fromJson(passJson);
    } else {
      // TODO(any): Create proper exception
      throw Exception('The order.json file is missing');
    }
  }
}
