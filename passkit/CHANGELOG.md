## 0.0.5

- Add signature validation
- Rename `skipVerification` to `skipChecksumVerification`. This is a breaking change.

## 0.0.4

- Add some missing `toJson` methods.
- Improve readme
- Add checksum validation (signature verification is still missing)
- Change `webServiceUrl` from `String?` to `Uri?`. This is a breaking change
- Fix building URLs for the PassKit web service
- Remove `formatType` from `Barcode`. `Barcode.format` is an enum instead. 
  - This is a breaking change
  - Also drop the dependency on `package:barcode`
- Fix loading of the correct resolution

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
