import 'package:csslib/parser.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:passkit/src/pkpass/barcode.dart';
import 'package:passkit/src/pkpass/beacon.dart';
import 'package:passkit/src/pkpass/location.dart';
import 'package:passkit/src/pkpass/nfc.dart';
import 'package:passkit/src/pkpass/parse_utils.dart';
import 'package:passkit/src/pkpass/pass_structure.dart';
import 'package:passkit/src/pkpass/semantics.dart';

part 'pass_data.g.dart';

@JsonSerializable(includeIfNull: false)
class PassData {
  PassData({
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
    this.sharingProhibited,
    this.authenticationToken,
    this.webServiceURL,
    this.nfc,
    this.semantics,
  });

  factory PassData.fromJson(Map<String, dynamic> json) =>
      _$PassDataFromJson(json);

  Map<String, dynamic> toJson() => _$PassDataToJson(this);

  /// Required. Brief description of the pass, used by the iOS accessibility
  /// technologies.
  ///
  /// Don't try to include all of the data on the pass in its description,
  /// just include enough detail to distinguish passes of the same type.
  // localizable
  @JsonKey(name: 'description')
  final String description;

  /// Required. Version of the file format. The value must be 1.
  @JsonKey(name: 'formatVersion')
  final int formatVersion;

  /// Required. Display name of the organization that originated and signed the
  /// pass.
  // localizable
  @JsonKey(name: 'organizationName')
  final String organizationName;

  /// Required. Pass type identifier, as issued by Apple. The value must
  /// correspond with your signing certificate.
  @JsonKey(name: 'passTypeIdentifier')
  final String passTypeIdentifier;

  /// Required. Serial number that uniquely identifies the pass.
  /// No two passes with the same pass type identifier may have the same
  /// serial number.
  @JsonKey(name: 'serialNumber')
  final String serialNumber;

  /// Required. Team identifier of the organization that originated and signed
  /// the pass, as issued by Apple.
  @JsonKey(name: 'teamIdentifier')
  final String teamIdentifier;

  /// Optional. A URL to be passed to the associated app when launching it.
  /// The app receives this URL in the
  /// application:didFinishLaunchingWithOptions: and
  /// application:openURL:options: methods of its app delegate.
  /// If this key is present, the associatedStoreIdentifiers key must also be
  /// present.
  @JsonKey(name: 'appLaunchURL')
  final String? appLaunchURL;

  /// Optional. A list of iTunes Store item identifiers for the associated apps.
  ///
  /// Only one item in the list is used—the first item identifier for an app
  /// compatible with the current device. If the app is not installed, the link
  /// opens the App Store and shows the app. If the app is already installed,
  /// the link launches the app.
  @JsonKey(name: 'associatedStoreIdentifiers')
  final List<int>? associatedStoreIdentifiers;

  /// Optional. Custom information for companion apps. This data is not
  /// displayed to the user.
  /// For example, a pass for a cafe could include information about the user’s
  /// favorite drink and sandwich in a machine-readable form for the companion
  /// app to read, making it easy to place an order for “the usual” from the
  /// app.
  /// Available in iOS 7.0.
  @JsonKey(name: 'userInfo')
  final Map<String, dynamic>? userInfo;

  /// Optional. Date and time when the pass expires.
  /// The value must be a complete date with hours and minutes, and may
  /// optionally include seconds.
  /// Available in iOS 7.0.
  // W3C date, as a string
  @JsonKey(name: 'expirationDate')
  final DateTime? expirationDate;

  /// Optional. Indicates that the pass is void—for example, a one time use
  /// coupon that has been redeemed. The default value is false.
  /// Available in iOS 7.0.
  @JsonKey(name: 'voided')
  final bool? voided;

  /// Optional. Beacons marking locations where the pass is relevant.
  /// For these dictionaries’ keys, see Beacon Dictionary Keys
  /// Available in iOS 7.0.
  @JsonKey(name: 'beacons')
  final List<Beacon>? beacons;

  /// Optional. Locations where the pass is relevant. For example, the location
  /// of your store.
  /// For these dictionaries’ keys, see Location Dictionary Keys.
  @JsonKey(name: 'locations')
  final List<Location>? locations;

  /// Optional. Maximum distance in meters from a relevant latitude and
  /// longitude that the pass is relevant. This number is compared to the pass’s
  /// default distance and the smaller value is used.
  /// Available in iOS 7.0.
  @JsonKey(name: 'maxDistance')
  final num? maxDistance;

  /// Recommended for event tickets and boarding passes; otherwise optional.
  /// Date and time when the pass becomes relevant. For example, the start time
  /// of a movie.
  /// The value must be a complete date with hours and minutes, and may
  /// optionally include seconds.
  // W3C date, as a string
  @JsonKey(name: 'relevantDate')
  final DateTime? relevantDate;

  /// Information specific to a boarding pass.
  @JsonKey(name: 'boardingPass')
  final PassStructure? boardingPass;

  /// Information specific to a coupon.
  @JsonKey(name: 'coupon')
  final PassStructure? coupon;

  /// Information specific to an event ticket.
  @JsonKey(name: 'eventTicket')
  final PassStructure? eventTicket;

  /// Information specific to a generic pass.
  @JsonKey(name: 'generic')
  final PassStructure? generic;

  /// Information specific to a store card.
  @JsonKey(name: 'storeCard')
  final PassStructure? storeCard;

  /// Optional. Information specific to the pass’s barcode. For this
  /// dictionary’s keys, see Barcode Dictionary Keys.
  /// Note:Deprecated in iOS 9.0 and later; use barcodes instead.
  @JsonKey(name: 'barcode')
  final Barcode? barcode;

  /// Optional. Information specific to the pass’s barcode. The system uses the
  /// first valid barcode dictionary in the array. Additional dictionaries can
  /// be added as fallbacks. For this dictionary’s keys,
  /// see Barcode Dictionary Keys.
  /// Note: Available only in iOS 9.0 and later.
  @JsonKey(name: 'barcodes')
  final List<Barcode>? barcodes;

  /// Optional. Background color of the pass, specified as an CSS-style RGB
  /// triple. For example, rgb(23, 187, 82).
  @JsonKey(name: 'backgroundColor', fromJson: parseColor, toJson: colorToString)
  final Color? backgroundColor;

  /// Optional. Foreground color of the pass, specified as a CSS-style RGB
  /// triple. For example, rgb(100, 10, 110).
  @JsonKey(name: 'foregroundColor', fromJson: parseColor, toJson: colorToString)
  final Color? foregroundColor;

  /// Optional for event tickets and boarding passes; otherwise not allowed.
  /// Identifier used to group related passes. If a grouping identifier is
  /// specified, passes with the same style, pass type identifier, and grouping
  /// identifier are displayed as a group. Otherwise, passes are grouped
  /// automatically.
  /// Use this to group passes that are tightly related, such as the boarding
  /// passes for different connections of the same trip.
  /// Available in iOS 7.0.
  @JsonKey(name: 'groupingIdentifier')
  final String? groupingIdentifier;

  /// Optional. Color of the label text, specified as a CSS-style RGB triple.
  /// For example, rgb(255, 255, 255).
  /// If omitted, the label color is determined automatically.
  @JsonKey(name: 'labelColor', fromJson: parseColor, toJson: colorToString)
  final Color? labelColor;

  /// Optional. Text displayed next to the logo on the pass.
  // localizable string
  @JsonKey(name: 'logoText')
  final String? logoText;

  /// Optional. If true, the strip image is displayed without a shine effect.
  /// The default value prior to iOS 7.0 is false.
  /// In iOS 7.0, a shine effect is never applied, and this key is deprecated.
  @JsonKey(name: 'suppressStripShine')
  final bool? suppressStripShine;

  /// A Boolean value introduced in iOS 11 that controls whether to show the
  /// Share button on the back of a pass. A value of true removes the button.
  /// The default value is false. This flag has no effect in earlier versions of
  /// iOS, nor does it prevent sharing the pass in some other way.
  @JsonKey(name: 'sharingProhibited')
  final bool? sharingProhibited;

  /// The authentication token to use with the web service. The token must be 16
  /// characters or longer.
  @JsonKey(name: 'authenticationToken')
  final String? authenticationToken;

  /// The URL of a web service that conforms to the API described in PassKit Web
  /// Service Reference.
  /// The web service must use the HTTPS protocol; the leading https:// is
  /// included in the value of this key.
  /// On devices configured for development, there is UI in Settings to allow
  /// HTTP web services.
  @JsonKey(name: 'webServiceURL')
  final Uri? webServiceURL;

  /// Optional. Information used for Value Added Service Protocol transactions.
  /// For this dictionary’s keys, see NFC Dictionary Keys.
  /// Available in iOS 9.0.
  @JsonKey(name: 'nfc')
  final Nfc? nfc;

  /// You can augment the user-visible information on Wallet passes with
  /// machine-readable metadata known as semantic tags. The metadata in semantic
  /// tags helps the system better understand Wallet passes and suggest relevant
  /// actions for the user to take on their installed passes.
  ///
  /// An object that contains machine-readable metadata the system uses to offer
  /// a pass and suggest related actions.
  @JsonKey(name: 'semantics')
  final Semantics? semantics;
}
