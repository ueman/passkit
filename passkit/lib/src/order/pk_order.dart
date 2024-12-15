import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:passkit/src/archive_extensions.dart';
import 'package:passkit/src/archive_file_extension.dart';
import 'package:passkit/src/crypto/signature_verification.dart';
import 'package:passkit/src/crypto/write_signature.dart';
import 'package:passkit/src/pk_image.dart';
import 'package:passkit/src/pk_image_extension.dart';
import 'package:passkit/src/pkpass/exceptions.dart';
import 'package:passkit/src/strings/strings_writer.dart';
import 'package:passkit/src/utils.dart';
import 'package:pkcs7/pkcs7.dart';

import 'order_data.dart';

class PkOrder {
  PkOrder({
    required this.order,
    this.manifest,
    this.sourceData,
    this.languageData,
  });

  /// Parses bytes to a [PkOrder] instance.
  /// Setting [skipChecksumVerification] and [skipSignatureVerification] to true
  /// disables checksum or signature verification and validation.
  // TODO(ueman): Provide an async method for this.
  static PkOrder fromBytes(
    final Uint8List bytes, {
    bool skipChecksumVerification = false,
    bool skipSignatureVerification = false,
    X509? overrideWwdrCert,
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
            archive.findFile('manifest.json')!.binaryContent;
        final signatureContent = archive.findFile('signature')!.binaryContent;

        if (!verifySignature(
          signatureBytes: signatureContent,
          manifestBytes: manifestContent,
          identifier: order.orderTypeIdentifier,
          teamIdentifier: order.merchant.merchantIdentifier,
          overrideWwdrCert: overrideWwdrCert,
        )) {
          throw Exception('validation failed');
        }
      }
    }

    return PkOrder(
      // data
      order: order,
      manifest: manifest,
      languageData: archive.getTranslations(),
      // source
      sourceData: bytes,
    ).._archive = archive;
  }

  final OrderData order;

  /// Mapping of files to their respective checksums. Typically not relevant for
  /// users of this package.
  final Map<String, dynamic>? manifest;

  /// List of available languages. Each value is a language identifier
  Iterable<String> get availableLanguages => languageData?.keys ?? [];

  /// Translations for this PkPass.
  /// Consists of a mapping of language identifier to translation key-value
  /// pairs.
  final Map<String, Map<String, String>>? languageData;

  late Archive _archive;

  // TODO(any): Do proper image loading for orders
  //            Do a sanity check for paths that already contains @2x/@3x modifier
  //            What about localized images?
  //
  // The Apple docs state that
  // > Adding an image of the same name to the top-level folder of the order
  // > file overrides any localized versions.
  // So non-localized images are actually the fallback.
  PkImage loadImage(String path, {String? locale}) {
    assert(path.isNotEmpty);

    final fileExtension = path.split('.').last;
    final twoXResPath =
        path.replaceAll('.$fileExtension', '@2x.$fileExtension');
    final threeXResPath =
        path.replaceAll('.$fileExtension', '@3x.$fileExtension');

    return PkImage(
      image1: _archive.findFile(path)?.content,
      image2: _archive.findFile(twoXResPath)?.content,
      image3: _archive.findFile(threeXResPath)?.content,
    );
  }

  /// The bytes of this PkPass
  ///
  /// `null` if this object was created with the default constructor.
  final Uint8List? sourceData;

  /// Indicates whether a webservices is available.
  bool get isWebServiceAvailable => order.webServiceURL != null;

  /// Creates a PkOrder file. If this instance was created via [PkOrder.fromBytes]
  /// it overwrites the signature if possible.
  ///
  /// When written to disk, the file should have an ending of `.order`.
  ///
  /// [certificatePem] is the certificate to be used to sign the PkPass file.
  ///
  /// [privateKeyPem] is the private key PEM file. Right now,
  /// it's only supported if it's not password protected.
  ///
  /// Read more about signing [here](https://github.com/ueman/passkit/blob/master/passkit/SIGNING.md).
  ///
  /// If either [certificatePem] or [privateKeyPem] is null, the resulting PkPass
  /// will not be properly signed, but still generated.
  ///
  /// Setting [overrideWwdrCert] overrides the Apple WWDR certificate, that's
  /// shipped with this library.
  ///
  /// Apple's documentation [here](https://developer.apple.com/documentation/walletorders)
  /// explains which fields to set.
  ///
  /// ## Images
  ///
  /// Images in order files work quite differently from passes, since they have
  /// no predefined name.
  /// You have to add the name, for example `something.png`, to the various properties,
  /// and then pass the the image with the name for the [images] argument here.
  /// Make sure the names always match, otherwise the order file might not work!
  ///
  /// Remarks:
  /// - Image sizes aren't checked, which means it's possible to create orders
  ///   that look odd and wrong in the Apple Wallet app or in
  ///   [passkit_ui](https://pub.dev/packages/passkit_ui)
  Uint8List? write({
    required String? certificatePem,
    required String? privateKeyPem,
    X509? overrideWwdrCert,
    required List<(String name, PkImage image)> images,
  }) {
    final archive = Archive();

    final orderContent = utf8JsonEncode(order.toJson());
    final orderFile = ArchiveFile(
      'order.json',
      orderContent.length,
      orderContent,
    );
    archive.addFile(orderFile);

    // TODO(any): Write validation
    for (final image in images) {
      image.$2.writeToArchive(archive, image.$1.split('.').first);
    }

    final translationEntries = languageData?.entries;
    if (translationEntries != null && translationEntries.isNotEmpty) {
      // TODO(any): Ensure every translation file has the same amount of key value pairs.

      for (final entry in translationEntries) {
        final name = '${entry.key}.lproj/pass.strings';
        final localizationFile =
            ArchiveFile.string(name, toStringsFile(entry.value));
        archive.addFile(localizationFile);
      }
    }

    final manifestFile = archive.createManifest();

    if (certificatePem != null && privateKeyPem != null) {
      final signature = writeSignature(
        certificatePem,
        privateKeyPem,
        manifestFile,
        order.orderTypeIdentifier,
        order.merchant.merchantIdentifier,
        true,
        overrideWwdrCert,
      );

      final signatureFile = ArchiveFile(
        'signature',
        signature.length,
        signature,
      );
      archive.addFile(signatureFile);
    }

    final pkOrder = ZipEncoder().encode(archive);
    return Uint8List.fromList(pkOrder);
  }

  PkOrder copyWith({
    OrderData? order,
    Map<String, dynamic>? manifest,
    Map<String, Map<String, String>>? languageData,
    Uint8List? sourceData,
  }) {
    return PkOrder(
      order: order ?? this.order,
      manifest: manifest ?? this.manifest,
      languageData: languageData ?? this.languageData,
      sourceData: sourceData ?? this.sourceData,
    );
  }
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
