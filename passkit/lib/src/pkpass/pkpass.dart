import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:meta/meta.dart';
import 'package:passkit/src/archive_file_extension.dart';
import 'package:passkit/src/pk_image.dart';
import 'package:passkit/src/pkpass/exceptions.dart';
import 'package:passkit/src/pkpass/pass_data.dart';
import 'package:passkit/src/pkpass/pass_type.dart';
import 'package:passkit/src/pkpass/personalization.dart';
import 'package:passkit/src/signature_verification.dart';
import 'package:passkit/src/strings_parser/naive_strings_file_parser.dart';
import 'package:passkit/src/utils.dart';
import 'package:passkit/src/write_signature.dart';

/// https://developer.apple.com/library/archive/documentation/UserExperience/Reference/PassKit_Bundle/Chapters/Introduction.html
/// https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/index.html#//apple_ref/doc/uid/TP40012195
///
/// Contents:
/// https://developer.apple.com/library/archive/documentation/UserExperience/Reference/PassKit_Bundle/Chapters/PackageStructure.html#//apple_ref/doc/uid/TP40012026-CH1-SW1
///
/// The file structure of a `.pkpass` file looks like the following:
/// de-de.lproj/
/// ├─ logo.png
/// ├─ pass.string
/// en.lproj/
/// ├─ logo.png
/// ├─ logo@2x.png
/// ├─ pass.strings
/// icon.png
/// icon@2x.png
/// manifest.json
/// pass.json
/// signature
class PkPass {
  PkPass({
    required this.pass,
    required this.manifest,
    required this.sourceData,
    this.background,
    this.footer,
    this.icon,
    this.logo,
    this.strip,
    this.thumbnail,
    this.languageData,
    this.personalization,
    this.personalizationLogo,
  });

  /// Parses bytes to a [PkPass] instance.
  ///
  /// Setting [skipChecksumVerification] to true disables any checksum
  /// verification and validation.
  ///
  /// Setting [skipSignatureVerification] to true disables any signature
  /// verification and validation. This may be needed for older passes which are
  /// signed with an out of date [Apple WWDR](https://developer.apple.com/help/account/reference/wwdr-intermediate-certificates/)
  /// certificate.
  // TODO(any): Provide an async method for this.
  static PkPass fromBytes(
    final Uint8List bytes, {
    bool skipChecksumVerification = false,
    bool skipSignatureVerification = false,
  }) {
    if (bytes.isEmpty) {
      throw EmptyBytesException();
    }

    ZipDecoder decoder = ZipDecoder();
    final archive = decoder.decodeBytes(bytes);

    final manifest = archive.readManifest();
    final passData = archive.readPass();
    if (!skipChecksumVerification) {
      archive.checkSha1Checksums(manifest);
      if (!skipSignatureVerification) {
        final manifestContent =
            archive.findFile('manifest.json')!.binaryContent;
        final signatureContent = archive.findFile('signature')!.binaryContent;

        if (!verifySignature(
          signatureBytes: signatureContent,
          manifestBytes: manifestContent,
          teamIdentifier: passData.teamIdentifier,
          identifier: passData.passTypeIdentifier,
        )) {
          throw Exception('validation failed');
        }
      }
    }

    return PkPass(
      // data
      pass: passData,
      manifest: manifest,
      personalization: archive.readPersonalization(),
      languageData: archive.getTranslations(),
      // images
      // TODO(ueman): Images can be localized, too
      //              Maybe it's better to have an on-demand API, something like
      //              PkPass().getLogo(resolution: 3, languageCode: 'en_EN').
      logo: archive.loadImage('logo'),
      icon: archive.loadImage('icon'),
      footer: archive.loadImage('footer'),
      thumbnail: archive.loadImage('thumbnail'),
      strip: archive.loadImage('strip'),
      background: archive.loadImage('background'),
      personalizationLogo: archive.loadImage('personalizationLogo'),
      // source
      sourceData: bytes,
    );
  }

  /// Parses a `.pkpasses` to a list of [PkPass]es.
  /// The mimetype of that file is `application/vnd.apple.pkpasses`.
  /// A `.pkpasses` file cna contain up to ten [PkPass]es.
  ///
  /// Setting [skipVerification] to true disables any checksum or signature
  /// verification and validation.
  ///
  /// Read more at:
  /// - https://developer.apple.com/documentation/walletpasses/distributing_and_updating_a_pass#3793284
  // TODO(ueman): Detect whether it's maybe just a single pass, and then
  // gracefully fall back to just parsing the PkPass file.
  // TODO(ueman): Provide an async method for this.
  static List<PkPass> passesFromBytes(
    final Uint8List bytes, {
    bool skipChecksumVerification = false,
    bool skipSignatureVerification = false,
  }) {
    if (bytes.isEmpty) {
      throw EmptyBytesException();
    }
    ZipDecoder decoder = ZipDecoder();
    final archive = decoder.decodeBytes(bytes);
    final pkPasses =
        archive.files.where((file) => file.name.endsWith('.pkpass')).toList();
    return pkPasses
        .map(
          (file) => fromBytes(
            file.binaryContent,
            skipChecksumVerification: skipChecksumVerification,
            skipSignatureVerification: skipSignatureVerification,
          ),
        )
        .toList();
  }

  /// Data of the PkPass
  final PassData pass;

  /// Mapping of files to their respective checksums. Typically not relevant for
  /// users of this package.
  final Map<String, dynamic>? manifest;

  /// The [PassType] of this PkPass.
  PassType get type {
    if (pass.boardingPass != null) {
      return PassType.boardingPass;
    }
    if (pass.coupon != null) {
      return PassType.coupon;
    }
    if (pass.eventTicket != null) {
      return PassType.eventTicket;
    }
    if (pass.generic != null) {
      return PassType.generic;
    }
    if (pass.storeCard != null) {
      return PassType.storeCard;
    }
    throw Exception('unknown pass type');
  }

  /// The image displayed as the background of the front of the pass.
  final PkImage? background;

  /// The image displayed on the front of the pass near the barcode.
  final PkImage? footer;

  /// The pass’s icon. This is displayed in notifications and in emails that
  /// have a pass attached, and on the lock screen.
  /// When it is displayed, the icon gets a shine effect and rounded corners.
  final PkImage? icon;

  /// The image displayed on the front of the pass in the top left.
  final PkImage? logo;

  /// The image displayed behind the primary fields on the front of the pass.
  final PkImage? strip;

  /// An additional image displayed on the front of the pass.
  /// For example, on a membership card, the thumbnail could be used
  /// to a picture of the cardholder.
  final PkImage? thumbnail;

  /// Use a 150 x 40 point png file.
  /// This logo is displayed at the top of the signup form.
  final PkImage? personalizationLogo;

  /// This file specifies the personal information requested by the signup form.
  /// It also contains a description of the program and (optionally) the
  /// program’s terms and conditions.
  ///
  /// Learn more at
  /// https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/PassPersonalization.html#//apple_ref/doc/uid/TP40012195-CH12-SW2
  final Personalization? personalization;

  /// List of available languages. Each value is a language identifier as
  /// described in https://developer.apple.com/documentation/xcode/choosing-localization-regions-and-scripts
  Iterable<String> get availableLanguages => languageData?.keys ?? [];

  /// Translations for this PkPass.
  /// Consists of a mapping of language identifier to translation key-value
  /// pairs.
  /// The language identifier looks as described in
  /// https://developer.apple.com/documentation/xcode/choosing-localization-regions-and-scripts
  final Map<String, Map<String, dynamic>>? languageData;

  /// The bytes of this PkPass
  /// Returns `null` when this instance wasn't read from a file.
  final Uint8List? sourceData;

  /// Indicates whether a webservices is available.
  bool get isWebServiceAvailable => pass.webServiceURL != null;

  /// Creates a PkPass file. If this instance was created via [PkPass.fromBytes]
  /// it overwrites the signature if possible.
  ///
  /// When written to disk, the file should have an ending of `.pkpass`.
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
  /// Remarks:
  /// - There's no support for verifying that the signature matches the PkPass
  /// - There's no support for localization
  /// - There's no support for personalization
  /// - Image sizes aren't checked, which means it's possible to create passes
  ///   that look odd and wrong in Apple wallet or [passkit_ui](https://pub.dev/packages/passkit_ui)
  @experimental
  Uint8List? write({
    String? certificatePem,
    String? privateKeyPem,
  }) {
    final archive = Archive();

    final passContent = utf8JsonEncoder.convert(pass.toJson());
    final passFile = ArchiveFile(
      'pass.json',
      passContent.length,
      passContent,
    );
    archive.addFile(passFile);
    /*
    if (personalization != null) {
      encoder.addFile(
        ArchiveFile.string(
          'personalization.json',
          jsonEncode(personalization!.toJson()),
        ),
      );
    }
    */

    logo?.writeToArchive(archive, 'logo');
    background?.writeToArchive(archive, 'background');
    icon?.writeToArchive(archive, 'icon');
    footer?.writeToArchive(archive, 'footer');
    strip?.writeToArchive(archive, 'strip');
    thumbnail?.writeToArchive(archive, 'thumbnail');

    final manifest = <String, String>{};
    for (final file in archive.files) {
      manifest[file.name] = sha1.convert(file.binaryContent).toString();
    }

    final manifestContent = utf8JsonEncoder.convert(manifest);
    final manifestFile = ArchiveFile(
      'manifest.json',
      manifestContent.length,
      manifestContent,
    );
    archive.addFile(manifestFile);

    if (certificatePem != null && privateKeyPem != null) {
      final signature = writeSignature(
        certificatePem,
        privateKeyPem,
        manifestFile.binaryContent,
        pass.passTypeIdentifier,
        pass.teamIdentifier,
        true,
      );

      final signatureFile = ArchiveFile(
        'signature',
        signature.length,
        signature,
      );
      archive.addFile(signatureFile);
    }

    final pkpass = ZipEncoder().encode(archive);
    if (pkpass == null) {
      return null;
    }
    return Uint8List.fromList(pkpass);
  }
}

// This is intentionally not exposed to keep this an implementation detail.
// Tests should be written against the PkPass class directly.
extension on Archive {
  Uint8List? findBytesForFile(String fileName) =>
      findFile(fileName)?.binaryContent;

  /// Returns a map of locale to a map of resolution to image bytes.
  /// Returns null, if no image is localized
  Map<String, Map<int, Uint8List>>? loadLocalizedImage(String imageName) {
    final map = <String, Map<int, Uint8List>>{};
    for (final file in files) {
      final fileName = file.name;
      if (!fileName.endsWith('.png')) {
        // file is not an image
        continue;
      }
      if (!fileName.contains(imageName)) {
        // file is not the image that's been searched for
        continue;
      }
      if (!fileName.contains('/')) {
        // this is a non-localized image, which has been loaded before
        continue;
      }
      // It can be assumed now that the image is localized

      // get the language part of the name, which is something like 'en.lpoj/icon@2x.png'
      final language = fileName.split('.').first;
      if (!map.containsKey(language)) {
        map[language] = {};
      }

      if (fileName.endsWith('@2x.png')) {
        map[language]![2] = file.binaryContent;
      } else if (fileName.endsWith('@3x.png')) {
        map[language]![3] = file.binaryContent;
      } else {
        map[language]![1] = file.binaryContent;
      }
    }

    map.removeWhere((lang, images) {
      return images.values.isEmpty;
    });

    if (map.isEmpty) {
      return null;
    }
    return map;
  }

  Map<String, dynamic>? findFileAndReadAsJson(String fileName) {
    final bytes = findBytesForFile(fileName);
    if (bytes == null) {
      return null;
    }
    return utf8JsonDecoder.convert(bytes) as Map<String, dynamic>?;
  }

  PkImage? loadImage(String name) {
    return PkImage.fromImages(
      image1: findBytesForFile('$name.png'),
      image2: findBytesForFile('$name@2x.png'),
      image3: findBytesForFile('$name@3x.png'),
      localizedImages: loadLocalizedImage(name),
    );
  }

  Map<String, Map<String, String>> getTranslations() {
    final languageData = <String, Map<String, String>>{};

    // The Archive object doesn't have APIs to work with folders.
    // Instead the file name contains a `/` indicating the file is within a folder.
    // Example: `file.name == en.lproj/pass.strings`
    final translationFiles = files
        .where((element) => element.isFile)
        .where((file) => file.name.endsWith('.lproj/pass.strings'));

    for (final languageFile in translationFiles) {
      final language = languageFile.name.split('.').first;

      languageData[language] = parseStringsFile(languageFile.binaryContent);
    }
    return languageData;
  }

  PassData readPass() {
    final passJson = findFileAndReadAsJson('pass.json');
    if (passJson != null) {
      return PassData.fromJson(passJson);
    } else {
      throw MissingPassJsonException();
    }
  }

  Map<String, dynamic> readManifest() {
    final manifestJson = findFileAndReadAsJson('manifest.json');
    if (manifestJson != null) {
      return manifestJson;
    } else {
      throw MissingManifestJsonException();
    }
  }

  Personalization? readPersonalization() {
    final personalizationFile = findFileAndReadAsJson('personalization.json');
    if (personalizationFile != null) {
      return Personalization.fromJson(personalizationFile);
    }
    return null;
  }

  /// To create the manifest file, recursively list the files in the package
  /// (except the manifest file and signature), calculate the SHA-1 hash of the
  /// contents of those files, and store the data in a dictionary. The keys are
  /// relative paths to the file from the pass package. The values are the SHA-1
  /// hash (hex encoded) of the data at that path. Write this dictionary to the
  /// file manifest.json at the top level of the pass package.
  ///
  /// https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1
  void checkSha1Checksums(Map<String, dynamic> manifest) {
    final filesWithoutSignatureAndManifest = files.where((file) {
      return file.name != 'signature' && file.name != 'manifest.json';
    }).toList();

    final fileInArchiveCount = filesWithoutSignatureAndManifest.length;
    final manifestCount = manifest.length;
    if (fileInArchiveCount != manifestCount) {
      throw MissingChecksumException();
    }

    for (final file in filesWithoutSignatureAndManifest) {
      final checksumInManifest = manifest[file.name] as String?;
      final digest = sha1.convert(file.binaryContent);
      if (checksumInManifest != digest.toString()) {
        throw ChecksumMismatchException(file.name);
      }
    }
  }
}

extension on PkImage {
  void writeToArchive(Archive archive, String name) {
    if (image1 != null) {
      archive.addFile(ArchiveFile('$name.png', image1!.lengthInBytes, image1));
    }
    if (image2 != null) {
      archive
          .addFile(ArchiveFile('$name@2x.png', image2!.lengthInBytes, image2));
    }
    if (image3 != null) {
      archive
          .addFile(ArchiveFile('$name@3x.png', image3!.lengthInBytes, image3));
    }
  }
}
