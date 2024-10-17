import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:passkit/src/archive_extensions.dart';
import 'package:passkit/src/archive_file_extension.dart';
import 'package:passkit/src/crypto/signature_verification.dart';
import 'package:passkit/src/crypto/write_signature.dart';
import 'package:passkit/src/pk_image.dart';
import 'package:passkit/src/pk_image_extension.dart';
import 'package:passkit/src/pkpass/creation_failure_reason.dart';
import 'package:passkit/src/pkpass/exceptions.dart';
import 'package:passkit/src/pkpass/pass_data.dart';
import 'package:passkit/src/pkpass/pass_type.dart';
import 'package:passkit/src/pkpass/personalization.dart';
import 'package:passkit/src/strings/strings_writer.dart';
import 'package:passkit/src/utils.dart';
import 'package:pkcs7/pkcs7.dart';

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
    this.manifest,
    this.sourceData,
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
    X509? overrideWwdrCert,
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
          overrideWwdrCert: overrideWwdrCert,
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
      logo: archive.loadPkPassImage('logo'),
      icon: archive.loadPkPassImage('icon'),
      footer: archive.loadPkPassImage('footer'),
      thumbnail: archive.loadPkPassImage('thumbnail'),
      strip: archive.loadPkPassImage('strip'),
      background: archive.loadPkPassImage('background'),
      personalizationLogo: archive.loadPkPassImage('personalizationLogo'),
      // source
      sourceData: bytes,
    );
  }

  /// Parses a `.pkpasses` to a list of [PkPass]es.
  /// The mimetype of that file is `application/vnd.apple.pkpasses`.
  /// A `.pkpasses` file can contain up to ten [PkPass]es.
  ///
  /// Setting [skipChecksumVerification] to true disables any checksum
  /// verification and validation.
  ///
  /// Setting [skipSignatureVerification] to true disables any signature
  /// verification and validation. This may be needed for older passes which are
  /// signed with an out of date [Apple WWDR](https://developer.apple.com/help/account/reference/wwdr-intermediate-certificates/)
  /// certificate.
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
    X509? overrideWwdrCert,
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
            overrideWwdrCert: overrideWwdrCert,
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
  final Map<String, Map<String, String>>? languageData;

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
  /// Setting [overrideWwdrCert] overrides the Apple WWDR certificate, that's
  /// shipped with this library.
  ///
  /// Apple's documentation [here](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html)
  /// explains which fields to set for which type of pass.
  ///
  /// Throws a [CreationFailureException] if something is off.
  ///
  /// Remarks:
  /// - Image sizes aren't checked, which means it's possible to create passes
  ///   that look odd and wrong in the Apple Wallet app or in
  ///   [passkit_ui](https://pub.dev/packages/passkit_ui)
  Uint8List? write({
    required String? certificatePem,
    required String? privateKeyPem,
    X509? overrideWwdrCert,
  }) {
    if (!(certificatePem == null && privateKeyPem != null)) {
      throw ArgumentError(
        'You must either set certificatePem and privateKeyPem or none of them',
      );
    }

    final failureReasons = <CreationFailureReason>[];
    final passTypeIssue = _validatePassType();
    if (passTypeIssue != null) {
      failureReasons.add(passTypeIssue);
    }

    final archive = Archive();

    final passContent = utf8JsonEncode(pass.toJson());
    final passFile = ArchiveFile(
      'pass.json',
      passContent.length,
      passContent,
    );
    archive.addFile(passFile);

    if (personalization != null) {
      final personalizationContent = utf8JsonEncode(personalization!.toJson());
      final personalizationFile = ArchiveFile(
        'personalization.json',
        personalizationContent.length,
        personalizationContent,
      );
      archive.addFile(personalizationFile);
    }

    failureReasons.addAll(_validateCorrectImages());

    // TODO(any): Validate that each image is correctly localized
    logo?.writeToArchive(archive, 'logo');
    background?.writeToArchive(archive, 'background');
    icon?.writeToArchive(archive, 'icon');
    footer?.writeToArchive(archive, 'footer');
    strip?.writeToArchive(archive, 'strip');
    thumbnail?.writeToArchive(archive, 'thumbnail');
    personalizationLogo?.writeToArchive(archive, 'personalizationLogo');

    final translationEntries = languageData?.entries;
    if (translationEntries != null && translationEntries.isNotEmpty) {
      int translationCount = translationEntries.first.value.length;
      for (final entry in translationEntries) {
        if (entry.value.length != translationCount) {
          failureReasons.add(CreationFailureReason.incompleteTranslation);
          // After seeing one incomplete translation, there's no need to check
          // for more incomplete translations.
          break;
        }
      }

      for (final entry in translationEntries) {
        final name = '${entry.key}.lproj/pass.strings';
        final localizationFile =
            ArchiveFile.string(name, toStringsFile(entry.value));
        archive.addFile(localizationFile);
      }
    }

    final manifestFile = archive.createManifest();

    if (certificatePem != null) {
      final signature = writeSignature(
        certificatePem,
        privateKeyPem,
        manifestFile,
        pass.passTypeIdentifier,
        pass.teamIdentifier,
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

    if (failureReasons.isNotEmpty) {
      throw CreationFailureException(failureReasons);
    }

    final pkpass = ZipEncoder().encode(archive);
    return pkpass == null ? null : Uint8List.fromList(pkpass);
  }

  PkPass copyWith({
    PassData? pass,
    Map<String, dynamic>? manifest,
    PkImage? background,
    PkImage? footer,
    PkImage? icon,
    PkImage? logo,
    PkImage? strip,
    PkImage? thumbnail,
    PkImage? personalizationLogo,
    Personalization? personalization,
    Map<String, Map<String, String>>? languageData,
    Uint8List? sourceData,
  }) {
    return PkPass(
      pass: pass ?? this.pass,
      manifest: manifest ?? this.manifest,
      background: background ?? this.background,
      footer: footer ?? this.footer,
      icon: icon ?? this.icon,
      logo: logo ?? this.logo,
      strip: strip ?? this.strip,
      thumbnail: thumbnail ?? this.thumbnail,
      personalizationLogo: personalizationLogo ?? this.personalizationLogo,
      personalization: personalization ?? this.personalization,
      languageData: languageData ?? this.languageData,
      sourceData: sourceData ?? this.sourceData,
    );
  }

  // See https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1
  List<CreationFailureReason> _validateCorrectImages() {
    final missingImageFailures = <CreationFailureReason>[];
    // Every pass should have an icon and a logo
    if (icon == null) {
      missingImageFailures.add(CreationFailureReason.missingIconImage);
    }
    if (logo == null) {
      missingImageFailures.add(CreationFailureReason.missingLogoImage);
    }
    switch (type) {
      case PassType.boardingPass:
        // Since the footer is optional, there's no need to check for its presence.
        // While superfluous images are bad, it's nothing that breaks passes AFAIK.
        // Thus, validation for that can be added later if needed.
        return missingImageFailures;
      case PassType.coupon:
      case PassType.generic:
        // Since the strip is optional, there's no need to check for its presence.
        // While superfluous images are bad, it's nothing that breaks passes AFAIK.
        // Thus, validation for that can be added later if needed.
        return missingImageFailures;
      case PassType.storeCard:
        // Since the thumbnail is optional, there's no need to check for its presence.
        // While superfluous images are bad, it's nothing that breaks passes AFAIK.
        // Thus, validation for that can be added later if needed.
        return missingImageFailures;
      case PassType.eventTicket:
        // An event ticket can display logo, strip, background, or thumbnail images.
        // However, if you supply a strip image, don’t include a background or thumbnail image.
        // https://developer.apple.com/design/human-interface-guidelines/wallet#Event-tickets
        if (strip != null) {
          if (background != null) {
            missingImageFailures
                .add(CreationFailureReason.superfluousBackgroundImage);
          }
          if (thumbnail != null) {
            missingImageFailures
                .add(CreationFailureReason.superfluousThumbnailImage);
          }
        }

        return missingImageFailures;
    }
  }

  CreationFailureReason? _validatePassType() {
    final isPassTypeKnown = (pass.coupon ??
            pass.generic ??
            pass.boardingPass ??
            pass.eventTicket ??
            pass.storeCard) !=
        null;
    if (!isPassTypeKnown) {
      return CreationFailureReason.undefinedPassType;
    }
    return null;
  }
}

// This is intentionally not exposed to keep this an implementation detail.
// Tests should be written against the PkPass class directly.
extension on Archive {
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
    return utf8JsonDecode(bytes);
  }

  PkImage? loadPkPassImage(String name) {
    return PkImage.fromImages(
      image1: findBytesForFile('$name.png'),
      image2: findBytesForFile('$name@2x.png'),
      image3: findBytesForFile('$name@3x.png'),
      localizedImages: loadLocalizedImage(name),
    );
  }

  PassData readPass() {
    final passJson = findFileAndReadAsJson('pass.json');
    if (passJson != null) {
      return PassData.fromJson(passJson);
    } else {
      throw MissingPassJsonException();
    }
  }

  Personalization? readPersonalization() {
    final personalizationFile = findFileAndReadAsJson('personalization.json');
    if (personalizationFile != null) {
      return Personalization.fromJson(personalizationFile);
    }
    return null;
  }
}
