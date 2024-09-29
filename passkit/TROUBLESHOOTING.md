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

Next to that, you can use the <kbd>Console</kbd> app on macOS. Try opening your `.pkpass` file in an iOS Simulator or on a connected iPhone, and you should see logs in the Console app.
You can try searching for the pass type identifier, and you should see logs for your pass.

## Orders

If your order package doesn’t build correctly, check whether the following are all true:
- The `order.json` file contains all the required keys. For more information about required keys, see the top-level Order object.
- The value of the `orderTypeIdentifer` key in the `order.json` file matches the order type identifier of the signing certificate.
- The value of the `merchantIdentifier` key in the `order.json` file matches the Apple Developer account of the signing certificate.
- The server signing the order has a copy of the signing certificate and the WWDR Intermediate Certificates.
- The certificate isn’t expired.
- The `manifest.json` contains all the source files, including those in subdirectories.
- The images are in the correct format.
- The `order.json` and `manifest.json` files use the correct JSON syntax.
- Strings that require value formats are correct, such as the `createdAt` and `updatedAt` keys of Order, which require an RFC 3339 format, or `pickupWindowDuration`, which requires an ISO 8601-1 duration format.
- `updatedAt` is equal to `createdAt` if there are no updates, and `updatedAt` is monotonically increasing.
- Strings that require values from a finite set are correct, such as `Order.status` and `Order.ShippingFulfillment.status`.
- The names of localization folders use the correct language and region identifiers. For more information about language identifiers, see [Choosing localization regions and scripts](https://developer.apple.com/documentation/Xcode/choosing-localization-regions-and-scripts).
- Each localization folder contains all localized image files.
- Each localization folder contains the `order.strings` file for the order with localized strings.
- The keys for localized strings in the `order.json` file match those in the `order.strings` files.
- Each `order.strings` file contains the same number of localized strings and uses the same keys.
