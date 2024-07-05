import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:passkit/src/passkit/pass_data.dart';
import 'package:passkit/src/passkit/pass_type.dart';
import 'package:passkit/src/passkit/personalization.dart';
import 'package:passkit/src/passkit/pk_pass_image.dart';

/// Dart uses a special fast decoder when using a fused [Utf8Decoder] and [JsonDecoder].
/// This speeds up decoding.
/// See https://github.com/dart-lang/sdk/blob/5b2ea0c7a227d91c691d2ff8cbbeb5f7f86afdb9/sdk/lib/_internal/vm/lib/convert_patch.dart#L40
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
// TODO(ueman): Provide an async method for this.
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

  static PkPass fromBytes(final List<int> bytes) {
    Map<String, dynamic>? manifestJson;
    Map<String, dynamic>? passJson;
    Map<String, dynamic>? personalizationJson;

    ZipDecoder decoder = ZipDecoder();
    final archive = decoder.decodeBytes(bytes);

    // Manifest
    final manifestFile = archive.findFile('manifest.json');
    if (manifestFile != null) {
      manifestJson = _utf8JsonDecoder.convert(manifestFile.content as List<int>)
          as Map<String, dynamic>;
    } else {
      // TODO(ueman): throw
    }

    // pass.json
    final passFile = archive.findFile('pass.json');
    if (passFile != null) {
      passJson = _utf8JsonDecoder.convert(passFile.content as List<int>)
          as Map<String, dynamic>;
    } else {
      // TODO(ueman): throw
    }

    // pass.json
    final personalizationFile = archive.findFile('personalization.json');
    if (personalizationFile != null) {
      personalizationJson =
          _utf8JsonDecoder.convert(personalizationFile.content as List<int>)
              as Map<String, dynamic>;
    }

    // images
    // TODO(ueman): Images can be localized, too
    //              Maybe it's better to have an on-demand API, something like
    //              PkPass().getLogo(resolution: 3, languageCode: 'en_EN').
    final logo = _loadImage(archive, 'logo');
    final icon = _loadImage(archive, 'icon');
    final footer = _loadImage(archive, 'footer');
    final thumbnail = _loadImage(archive, 'thumbnail');
    final strip = _loadImage(archive, 'strip');
    final background = _loadImage(archive, 'background');
    final personalizationLogo = _loadImage(archive, 'personalizationLogo');

    Map<String, Map<String, String>> availableTranslations = {};

    for (final folder in archive.files.where((element) => !element.isFile)) {
      final languageName = folder.name.split('.').first;
      availableTranslations[languageName] = {};
    }

    return PkPass(
      pass: PassData.fromJson(passJson!),
      manifest: manifestJson!,
      logo: logo,
      icon: icon,
      footer: footer,
      thumbnail: thumbnail,
      sourceData: bytes,
      strip: strip,
      background: background,
      personalizationLogo: personalizationLogo,
      personalization: personalizationJson == null
          ? null
          : Personalization.fromJson(personalizationJson),
    );
  }

  /// Parses a `.pkpasses` to a list of [PkPass]es.
  /// The mimetype of that file is `application/vnd.apple.pkpasses`.
  /// A `.pkpasses` file cna contain up to ten [PkPass]es.
  /// Read more at:
  /// - https://developer.apple.com/documentation/walletpasses/distributing_and_updating_a_pass#3793284
  // TODO(ueman): Detect whether it's maybe just a single pass, and then
  // gracefully fall back to just parsing the PkPass file.
  // TODO(ueman): Provide an async method for this.
  static List<PkPass> passesFromBytes(final List<int> bytes) {
    ZipDecoder decoder = ZipDecoder();
    final archive = decoder.decodeBytes(bytes);
    final pkPasses =
        archive.files.where((file) => file.name.endsWith('.pkpass')).toList();
    return pkPasses
        .map((file) => fromBytes(file.content as List<int>))
        .toList();
  }

  static PkPassImage? _loadImage(Archive archive, String name) {
    final imageAt1Scale = archive.findFile('$name.png')?.content as List<int>?;
    final imageAt2Scale =
        archive.findFile('$name@2.png')?.content as List<int>?;
    final imageAt3Scale =
        archive.findFile('$name@3.png')?.content as List<int>?;
    return PkPassImage.fromImages(
      image1: imageAt1Scale == null ? null : Uint8List.fromList(imageAt1Scale),
      image2: imageAt2Scale == null ? null : Uint8List.fromList(imageAt2Scale),
      image3: imageAt3Scale == null ? null : Uint8List.fromList(imageAt3Scale),
    );
  }

  final PassData pass;

  final Map<String, dynamic> manifest;

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

  /// List of available languages
  Iterable<String> get availableLanguages => languageData?.keys ?? [];

  final Map<String, Map<String, dynamic>>? languageData;

  final List<int> sourceData;

  bool get isWebServiceAvailable => pass.webServiceURL != null;
}
