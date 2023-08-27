import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:csslib/parser.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:passkit/src/passkit/barcode.dart';
import 'package:passkit/src/passkit/beacon.dart';
import 'package:passkit/src/passkit/location.dart';
import 'package:passkit/src/passkit/nfc.dart';
import 'package:passkit/src/passkit/pass_structure.dart';
import 'package:passkit/src/passkit/pass_type.dart';
import 'package:passkit/src/passkit/parse_utils.dart';
import 'package:passkit/src/passkit/pk_pass_image.dart';

part 'pkpass.g.dart';

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
    this.background,
    this.footer,
    this.icon,
    this.logo,
    this.strip,
    this.thumbnail,
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

    List<String> availableTranslations = [];

    for (final folder in archive.files.where((element) => !element.isFile)) {
      // These are available translations
      availableTranslations.add(folder.name.split('.').first);
    }

    return PkPass(
      pass: Pass.fromJson(passJson!),
      manifest: manifestJson!,
      logo: logo,
      footer: footer,
    );
  }

  final Pass pass;

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
}

@JsonSerializable()
class Pass {
  Pass({
    required this.description,
    required this.formatVersion,
    required this.organizationName,
    required this.passTypeIdentifier,
    required this.serialNumber,
    required this.teamIdentifier,
    this.appLaunchURL,
    this.associatedStoreIdentifiers,
    this.userInfo,
    this.expirationDate,
    this.voided,
    this.beacons,
    this.locations,
    this.maxDistance,
    this.relevantDate,
    this.boardingPass,
    this.coupon,
    this.eventTicket,
    this.generic,
    this.storeCard,
    this.barcode,
    this.barcodes,
    this.backgroundColor,
    this.foregroundColor,
    this.groupingIdentifier,
    this.labelColor,
    this.logoText,
    this.suppressStripShine,
    this.authenticationToken,
    this.webServiceURL,
    this.nfc,
  });

  factory Pass.fromJson(Map<String, dynamic> json) => _$PassFromJson(json);

  /// Required. Brief description of the pass, used by the iOS accessibility
  /// technologies.
  ///
  /// Don't try to include all of the data on the pass in its description,
  /// just include enough detail to distinguish passes of the same type.
  // localizable
  final String description;

  /// Required. Version of the file format. The value must be 1.
  final int formatVersion;

  /// Required. Display name of the organization that originated and signed the
  /// pass.
  // localizable
  final String organizationName;

  /// Required. Pass type identifier, as issued by Apple. The value must
  /// correspond with your signing certificate.
  final String passTypeIdentifier;

  /// Required. Serial number that uniquely identifies the pass.
  /// No two passes with the same pass type identifier may have the same
  /// serial number.
  final String serialNumber;

  /// Required. Team identifier of the organization that originated and signed
  /// the pass, as issued by Apple.
  final String teamIdentifier;

  /// Optional. A URL to be passed to the associated app when launching it.
  /// The app receives this URL in the
  /// application:didFinishLaunchingWithOptions: and
  /// application:openURL:options: methods of its app delegate.
  /// If this key is present, the associatedStoreIdentifiers key must also be
  /// present.
  final String? appLaunchURL;

  /// Optional. A list of iTunes Store item identifiers for the associated apps.
  ///
  /// Only one item in the list is used—the first item identifier for an app
  /// compatible with the current device. If the app is not installed, the link
  /// opens the App Store and shows the app. If the app is already installed,
  /// the link launches the app.
  final List<int>? associatedStoreIdentifiers;

  /// Optional. Custom information for companion apps. This data is not
  /// displayed to the user.
  /// For example, a pass for a cafe could include information about the user’s
  /// favorite drink and sandwich in a machine-readable form for the companion
  /// app to read, making it easy to place an order for “the usual” from the
  /// app.
  /// Available in iOS 7.0.
  final Map<String, dynamic>? userInfo;

  /// Optional. Date and time when the pass expires.
  /// The value must be a complete date with hours and minutes, and may
  /// optionally include seconds.
  /// Available in iOS 7.0.
  // W3C date, as a string
  final DateTime? expirationDate;

  /// Optional. Indicates that the pass is void—for example, a one time use
  /// coupon that has been redeemed. The default value is false.
  /// Available in iOS 7.0.
  final bool? voided;

  /// Optional. Beacons marking locations where the pass is relevant.
  /// For these dictionaries’ keys, see Beacon Dictionary Keys
  /// Available in iOS 7.0.
  final List<Beacon>? beacons;

  /// Optional. Locations where the pass is relevant. For example, the location
  /// of your store.
  /// For these dictionaries’ keys, see Location Dictionary Keys.
  final List<Location>? locations;

  /// Optional. Maximum distance in meters from a relevant latitude and
  /// longitude that the pass is relevant. This number is compared to the pass’s
  /// default distance and the smaller value is used.
  /// Available in iOS 7.0.
  final num? maxDistance;

  /// Recommended for event tickets and boarding passes; otherwise optional.
  /// Date and time when the pass becomes relevant. For example, the start time
  /// of a movie.
  /// The value must be a complete date with hours and minutes, and may
  /// optionally include seconds.
  // W3C date, as a string
  final DateTime? relevantDate;

  /// Information specific to a boarding pass.
  final PassStructure? boardingPass;

  /// Information specific to a coupon.
  final PassStructure? coupon;

  /// Information specific to an event ticket.
  final PassStructure? eventTicket;

  /// Information specific to a generic pass.
  final PassStructure? generic;

  /// Information specific to a store card.
  final PassStructure? storeCard;

  /// Optional. Information specific to the pass’s barcode. For this
  /// dictionary’s keys, see Barcode Dictionary Keys.
  /// Note:Deprecated in iOS 9.0 and later; use barcodes instead.
  final Barcode? barcode;

  /// Optional. Information specific to the pass’s barcode. The system uses the
  /// first valid barcode dictionary in the array. Additional dictionaries can
  /// be added as fallbacks. For this dictionary’s keys,
  /// see Barcode Dictionary Keys.
  /// Note: Available only in iOS 9.0 and later.
  final List<Barcode>? barcodes;

  /// Optional. Background color of the pass, specified as an CSS-style RGB
  /// triple. For example, rgb(23, 187, 82).
  @JsonKey(fromJson: parseColor, toJson: colorToString)
  final Color? backgroundColor;

  /// Optional. Foreground color of the pass, specified as a CSS-style RGB
  /// triple. For example, rgb(100, 10, 110).
  @JsonKey(fromJson: parseColor, toJson: colorToString)
  final Color? foregroundColor;

  /// Optional for event tickets and boarding passes; otherwise not allowed.
  /// Identifier used to group related passes. If a grouping identifier is
  /// specified, passes with the same style, pass type identifier, and grouping
  /// identifier are displayed as a group. Otherwise, passes are grouped
  /// automatically.
  /// Use this to group passes that are tightly related, such as the boarding
  /// passes for different connections of the same trip.
  /// Available in iOS 7.0.
  final String? groupingIdentifier;

  /// Optional. Color of the label text, specified as a CSS-style RGB triple.
  /// For example, rgb(255, 255, 255).
  /// If omitted, the label color is determined automatically.
  @JsonKey(fromJson: parseColor, toJson: colorToString)
  final Color? labelColor;

  /// Optional. Text displayed next to the logo on the pass.
  // localizable string
  final String? logoText;

  /// Optional. If true, the strip image is displayed without a shine effect.
  /// The default value prior to iOS 7.0 is false.
  /// In iOS 7.0, a shine effect is never applied, and this key is deprecated.
  final bool? suppressStripShine;

  /// The authentication token to use with the web service. The token must be 16
  /// characters or longer.
  final String? authenticationToken;

  /// The URL of a web service that conforms to the API described in PassKit Web
  /// Service Reference.
  /// The web service must use the HTTPS protocol; the leading https:// is
  /// included in the value of this key.
  /// On devices configured for development, there is UI in Settings to allow
  /// HTTP web services.
  final String? webServiceURL;

  /// Optional. Information used for Value Added Service Protocol transactions.
  /// For this dictionary’s keys, see NFC Dictionary Keys.
  /// Available in iOS 9.0.
  final Nfc? nfc;
}
