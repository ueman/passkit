import 'package:csslib/parser.dart';
import 'package:passkit/passkit.dart';

/// Creates an opinionated [PkPass] for an event.
/// In order to further customize an event pass, use the various `copyWith`
/// methods available on the PkPass object and its various properties.
///
/// Use the event ticket style to give people entry into events like concerts,
/// movies, plays, and sporting events. Typically, each pass corresponds to a
/// specific event, but you can also use a single pass for several events,
/// as with a season ticket.
///
/// An event ticket can display logo, strip, background, or thumbnail images.
/// However, if you supply a strip image, don’t include a background or
/// thumbnail image. You can also include an extra row of up to four auxiliary
/// fields (for developer guidance, see the `row` property of [FieldDict.row]).
///
/// The [primaryFields] should contain an event description.
/// The [secondaryFields] should contain the user's info.
///
/// See als:
/// - https://developer.apple.com/design/human-interface-guidelines/wallet#Event-tickets
PkPass createEventWithThumbnail({
  required PkImage logo,
  required PkImage icon,
  PkImage? background,
  PkImage? thumbnail,
  required String description,
  required String organizationName,
  required String serialNumber,
  List<int>? associatedStoreIdentifiers,
  required Color backgroundColor,
  required Color foregroundColor,
  required Color labelColor,
  required Barcode barcode,
  required List<Location> locations,
  Uri? webServiceUri,
  required String logoText,
  DateTime? expirationDate,
  DateTime? relevantTime,
  required Semantics? semantics,
  required List<FieldDict>? primaryFields,
  required List<FieldDict>? secondaryFields,
  required List<FieldDict>? auxiliaryFields,
}) {
  return PkPass(
    pass: PassData(
      passTypeIdentifier: 'passTypeIdentifier',
      teamIdentifier: 'teamIdentifier',
      description: description,
      organizationName: organizationName,
      serialNumber: serialNumber,
      associatedStoreIdentifiers: associatedStoreIdentifiers,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      labelColor: labelColor,
      barcode: barcode,
      locations: locations,
      webServiceURL: webServiceUri,
      logoText: logoText,
      expirationDate: expirationDate,
      relevantDate: relevantTime,
      semantics: semantics,
      eventTicket: PassStructure(
        primaryFields: primaryFields,
        secondaryFields: secondaryFields,
        auxiliaryFields: auxiliaryFields,
      ),
    ),
    logo: logo,
    icon: icon,
    background: background,
    thumbnail: thumbnail,
  );
}
