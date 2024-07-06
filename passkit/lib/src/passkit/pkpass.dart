import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:passkit/src/passkit/exceptions.dart';
import 'package:passkit/src/passkit/pass_data.dart';
import 'package:passkit/src/passkit/pass_type.dart';
import 'package:passkit/src/passkit/personalization.dart';
import 'package:passkit/src/passkit/pk_pass_image.dart';
import 'package:passkit/src/strings_parser/naive_strings_file_parser.dart';

/// Dart uses a special fast decoder when using a fused [Utf8Decoder] and [JsonDecoder].
/// This speeds up decoding.
/// See
/// - https://github.com/dart-lang/sdk/blob/5b2ea0c7a227d91c691d2ff8cbbeb5f7f86afdb9/sdk/lib/_internal/vm/lib/convert_patch.dart#L40
final _utf8JsonDecoder = const Utf8Decoder().fuse(const JsonDecoder());

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

  /// Parses bytes to a [PkPass] file.
  /// Setting [skipVerification] to true disables any checksum or signature
  /// verification and validation.
  // TODO(ueman): Provide an async method for this.
  static PkPass fromBytes(
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

    return PkPass(
      // data
      pass: archive.readPass(),
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
    final List<int> bytes, {
    bool skipVerification = false,
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
            file.content as List<int>,
            skipVerification: skipVerification,
          ),
        )
        .toList();
  }

  /// Data of the PkPass
  final PassData pass;

  /// Mapping of files to their respective checksums. Typically not relevant for
  /// users of this package.
  final Map<String, dynamic> manifest;

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
    return PassType.unknown;
  }

  /// The image displayed as the background of the front of the pass.
  final PkPassImage? background;

  /// The image displayed on the front of the pass near the barcode.
  final PkPassImage? footer;

  /// The pass’s icon. This is displayed in notifications and in emails that
  /// have a pass attached, and on the lock screen.
  /// When it is displayed, the icon gets a shine effect and rounded corners.
  final PkPassImage? icon;

  /// The image displayed on the front of the pass in the top left.
  final PkPassImage? logo;

  /// The image displayed behind the primary fields on the front of the pass.
  final PkPassImage? strip;

  /// An additional image displayed on the front of the pass.
  /// For example, on a membership card, the thumbnail could be used
  /// to a picture of the cardholder.
  final PkPassImage? thumbnail;

  /// Use a 150 x 40 point png file.
  /// This logo is displayed at the top of the signup form.
  final PkPassImage? personalizationLogo;

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
  final List<int> sourceData;

  /// Indicates whether a webservices is available.
  bool get isWebServiceAvailable => pass.webServiceURL != null;
}

// This is intentionally not exposed to keep this an implementation detail.
// Tests should be written against the PkPass class directly.
extension on Archive {
  List<int>? findBytesForFile(String fileName) =>
      findFile(fileName)?.content as List<int>?;

  Uint8List? findUint8ListForFile(String fileName) {
    final data = findBytesForFile(fileName);
    return data == null ? null : Uint8List.fromList(data);
  }

  Map<String, dynamic>? findFileAndReadAsJson(String fileName) {
    final bytes = findBytesForFile(fileName);
    if (bytes == null) {
      return null;
    }
    return _utf8JsonDecoder.convert(bytes) as Map<String, dynamic>?;
  }

  PkPassImage? loadImage(String name) {
    return PkPassImage.fromImages(
      image1: findUint8ListForFile('$name.png'),
      image2: findUint8ListForFile('$name@2.png'),
      image3: findUint8ListForFile('$name@3.png'),
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

      languageData[language] =
          parseStringsFile(languageFile.content as List<int>);
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
      final digest = sha1.convert(file.content as List<int>);
      if (checksumInManifest != digest.toString()) {
        throw ChecksumMismatchException(file.name);
      }
    }
  }
}
