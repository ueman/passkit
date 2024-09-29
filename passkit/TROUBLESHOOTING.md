# Trouble Shooting Guide

## Passes

If your pass doesn’t build correctly, check whether the following are all true:
- The `pass.json` file contains all the required keys.
- The value of the `passTypeIdentifer` key in the `pass.json` file matches the pass type identifier of the signing certificate.
- The value of the `teamIdentifier` key in the pass.json file matches the Apple Developer account of the signing certificate.
- The machine signing the pass has a copy of the signing certificate.
- The certificate isn’t expired.
- The `manifest.json` contains all the source files, including those in subdirectories.
- The source contains all required images.
- The images are in the correct format.
- The `pass.json` and `manifest.json` files use the correct JSON syntax.
- Strings that require value formats are correct, such as the `value` and `attributedValue` keys of [PassFieldContent](https://developer.apple.com/documentation/walletpasses/passfieldcontent) which require an ISO 8601 date.
- The names of localization folders use the correct language and region identifiers.
- Each localization folder contains all localized image files.
- Each localization folder contain the `pass.strings` file for passes with localized strings.
- The `pass.strings` files use the correct syntax.
- The keys for localized strings in the `pass.json` file match those used in the `pass.strings` files.
- Each `pass.strings` file contains the same number of localized strings and uses the same keys.
