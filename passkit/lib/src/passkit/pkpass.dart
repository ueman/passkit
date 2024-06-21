import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:passkit/src/passkit/pass_data.dart';
import 'package:passkit/src/passkit/pass_type.dart';
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
  });

  static PkPass fromBytes(final List<int> bytes) {
    Map<String, dynamic>? manifestJson;
    Map<String, dynamic>? passJson;

    ZipDecoder decoder = ZipDecoder();
    final archive = decoder.decodeBytes(bytes);

    // Manifest
    final manifestFile = archive.findFile('manifest.json');
    if (manifestFile != null) {
      manifestJson = _utf8JsonDecoder.convert(manifestFile.content as List<int>)
          as Map<String, dynamic>;
    } else {
      // TODO throw
    }

    // pass.json
    final passFile = archive.findFile('pass.json');
    if (passFile != null) {
      passJson = _utf8JsonDecoder.convert(passFile.content as List<int>)
          as Map<String, dynamic>;
    } else {
      // TODO throw
    }

    // images
    // TODO: Images can be localized, too
    //       Maybe it's better to have an on-demand API, something like
    //       PkPass().getLogo(resolution: 3, languageCode: 'en_EN').
    final logo = _loadImage(archive, 'logo');
    final icon = _loadImage(archive, 'icon');
    final footer = _loadImage(archive, 'footer');
    final thumbnail = _loadImage(archive, 'thumbnail');
    final strip = _loadImage(archive, 'strip');
    final background = _loadImage(archive, 'background');

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
    );
  }

  static PkPassImage? _loadImage(Archive archive, String name) {
    final imageAt1Scale = archive.findFile('$name.png');
    final imageAt2Scale = archive.findFile('$name@2.png');
    final imageAt3Scale = archive.findFile('$name@3.png');
    return PkPassImage.fromImages(
      image1: imageAt1Scale == null
          ? null
          : Uint8List.fromList(imageAt1Scale.content as List<int>),
      image2: imageAt2Scale == null
          ? null
          : Uint8List.fromList(imageAt2Scale.content as List<int>),
      image3: imageAt3Scale == null
          ? null
          : Uint8List.fromList(imageAt3Scale.content as List<int>),
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

  /// List of available languages
  Iterable<String> get availableLanguages => languageData?.keys ?? [];

  final Map<String, Map<String, dynamic>>? languageData;

  // TODO
  /// The URL that opens the pass in the Wallet app.
  /// Use the openURL(_:) method to open the pass in the Wallet app.
  // final Uri? passURL;

  final List<int> sourceData;
}
