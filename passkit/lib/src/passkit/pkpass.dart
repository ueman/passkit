import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:passkit/src/passkit/pass_data.dart';
import 'package:passkit/src/passkit/pass_type.dart';
import 'package:passkit/src/passkit/pk_pass_image.dart';

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
    this.langageData,
  });

  static PkPass fromBytes(final List<int> bytes) {
    Map<String, dynamic>? manifestJson;
    Map<String, dynamic>? passJson;
    PkPassImage? logo;
    PkPassImage? footer;

    ZipDecoder decoder = ZipDecoder();
    final archive = decoder.decodeBytes(bytes);

    // Manifest
    final manifestFile = archive.findFile('manifest.json');
    if (manifestFile != null) {
      manifestJson = jsonDecode(utf8.decode(manifestFile.content as List<int>))
          as Map<String, dynamic>;
    }

    // pass.json
    final passFile = archive.findFile('pass.json');
    if (passFile != null) {
      passJson = jsonDecode(utf8.decode(passFile.content as List<int>))
          as Map<String, dynamic>;
    }

    // Logo
    final logo1 = archive.findFile('logo.png');
    final logo2 = archive.findFile('logo@2.png');
    final logo3 = archive.findFile('logo@3.png');
    logo = PkPassImage.fromImages(
      image1:
          logo1 == null ? null : Uint8List.fromList(logo1.content as List<int>),
      image2:
          logo2 == null ? null : Uint8List.fromList(logo2.content as List<int>),
      image3:
          logo3 == null ? null : Uint8List.fromList(logo3.content as List<int>),
    );

    // footer
    final footer1 = archive.findFile('footer.png');
    final footer2 = archive.findFile('footer@2.png');
    final footer3 = archive.findFile('footer@3.png');
    footer = PkPassImage.fromImages(
      image1: footer1 == null
          ? null
          : Uint8List.fromList(footer1.content as List<int>),
      image2: footer2 == null
          ? null
          : Uint8List.fromList(footer2.content as List<int>),
      image3: footer3 == null
          ? null
          : Uint8List.fromList(footer3.content as List<int>),
    );

    Map<String, Map<String, String>> availableTranslations = {};

    for (final folder in archive.files.where((element) => !element.isFile)) {
      final languageName = folder.name.split('.').first;
      availableTranslations[languageName] = {};
    }

    return PkPass(
      pass: PassData.fromJson(passJson!),
      manifest: manifestJson!,
      logo: logo,
      footer: footer,
      sourceData: bytes,
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
  Iterable<String> get availableLanguages => langageData?.keys ?? [];

  final Map<String, Map<String, dynamic>>? langageData;

  // TODO
  /// The URL that opens the pass in the Wallet app.
  /// Use the openURL(_:) method to open the pass in the Wallet app.
  // final Uri? passURL;

  final List<int> sourceData;
}
