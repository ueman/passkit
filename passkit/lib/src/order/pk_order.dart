import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:passkit/src/archive_extensions.dart';
import 'package:passkit/src/pkpass/exceptions.dart';
import 'package:passkit/src/pkpass/pk_pass_image.dart';
import 'package:passkit/src/pkpass/pkpass.dart';

import 'order_data.dart';

class PkOrder {
  PkOrder({
    required this.order,
    required this.manifest,
    required this.sourceData,
    this.languageData,
  });

  /// Parses bytes to a [PkPass] file.
  /// Setting [skipVerification] to true disables any checksum or signature
  /// verification and validation.
  // TODO(ueman): Provide an async method for this.
  static PkOrder fromBytes(
    final List<int> bytes, {
    bool skipVerification = false,
  }) {
    if (bytes.isEmpty) {
      throw EmptyBytesException();
    }

    ZipDecoder decoder = ZipDecoder();
    final archive = decoder.decodeBytes(bytes);

    final manifest = archive.readManifest();
    if (!skipVerification) {
      archive.checkSha1Checksums(manifest);
    }

    return PkOrder(
      // data
      order: archive.readOrder(),
      manifest: manifest,
      languageData: archive.getTranslations(),
      // source
      sourceData: bytes,
    ).._archive = archive;
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

  late Archive _archive;

  // TODO(any): Do proper image loading for orders
  //            Do a sanity check for paths that already contains @2x/@3x modifier
  PkImage loadImage(String path, {String? locale}) {
    assert(path.isNotEmpty);

    final fileExtension = path.split('.').last;
    final twoXResPath =
        path.replaceAll('.$fileExtension', '@2x.$fileExtension');
    final threeXResPath =
        path.replaceAll('.$fileExtension', '@3x.$fileExtension');

    return PkImage(
      image1: _archive.findFile(path)?.content as Uint8List?,
      image2: _archive.findFile(twoXResPath)?.content as Uint8List?,
      image3: _archive.findFile(threeXResPath)?.content as Uint8List?,
    );
  }

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
