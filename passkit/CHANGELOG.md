## 1.1.0

- Require `archive: ^4.0.0`
- Allow `intl: ">=0.18.0 <0.21.0"`

## 1.0.0

- This version is identical to 0.0.12

## 0.0.12

- Update readme and pubspec meta data

## 0.0.11

- `PkPass.write()` is no longer experimental
- Add webservice support for orders
- Add support for readong images of orders
- Add support for creating order files

## 0.0.10

- Only support `image: ^4.1.1`

## 0.0.9

- Increase [`intl`](https://pub.dev/packages/intl) version range, which makes it compatible with older Flutter versions
- Allow older versions of `archive`, `image`, `json_annotation`, `pointycastle` which should make version conflicts less likely
- Allow the library to be used on Dart 3.3 and newer
- Add convenience methods to create PkImage objects
  - `createIcon()` creates, scales and converts a given image to an icon according to the spec
  - `createLogo()` creates, scales and converts a given image to a logo according to the spec
  - `createFooter()` creates, scales and converts a given image to a footer according to the spec
- Add a couple more `copyWith` methods to various classes
- Add a `createEventWithThumbnail()` method, which creates an opinionated event PkPass object.

## 0.0.8

- Make it possible to override the bundled Apple WWDR G4 certificate
  - Use the `overrideWwdrCert` argument of `PkPass.fromBytes()`
  - Use the `overrideWwdrCert` argument of `PkOrder.fromBytes()`
- Added the ability to create localized passes
- Remove dependencies on the `encrypt` and `asn1lib` packages.

## 0.0.7

- The library is now able to create properly signed `pkpass` files that work with Apple Wallet.
  Follow the guide [here](https://github.com/ueman/passkit/blob/master/passkit/SIGNING.md) to learn more.
- Pretty much every use of `List<int>` has been changed to `Uint8List`. This is potentially breaking.

## 0.0.6

- Add ability to create PkPass signature via OpenSSL or other command line tools

## 0.0.5

- Add signature validation
- Export [Wallet Order Tracking](https://developer.apple.com/documentation/walletorders) related classes
- Rename `skipVerification` to `skipChecksumVerification`. 
  - This is a breaking change.
- Rename `PkPassImage` to `PkImage`.
  - This is a breaking change
- Experimental support for creating a PkPass file. Use the `PkPass().write()` method.
  - The file will not yet be accepted by Apple Wallet due to missing support for writing the pass signature 

## 0.0.4

- Add missing `toJson` methods.
- Improve readme
- Add checksum validation (signature verification is still missing)
- Change `webServiceUrl` from `String?` to `Uri?`. This is a breaking change
- Fix building URLs for the PassKit web service
- Remove `formatType` from `Barcode`. `Barcode.format` is an enum instead. 
  - This is a breaking change
  - Also drop the dependency on `package:barcode`
- Fix loading of the correct resolution for images

## 0.0.3

- Support for localization parsing. This is an experimental feature.
- Support for semantic properties.
- Support for reading `.pkpasses` files. These are bundles of `.pkpass` files.
- Updating a pass via the web service returns an instance of a `PkPass` object instead of a `UInt8List`. This is a breaking change.
- Improved readme
- Added an example.
- Add missing `row` attribute on auxiliary rows.
- Add personalization fields.
- It's no longer possible to request an image resolution lower than 1 or higher than 3.

## 0.0.2

- Make package with latest dependencies
- Improves documentation and readme
- Rename `langageData` to `languageData`
- Add webservice to request updates for PkPass files

## 0.0.1

- Initial version.
