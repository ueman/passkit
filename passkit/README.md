# PassKit

[![pub package](https://img.shields.io/pub/v/passkit.svg)](https://pub.dev/packages/passkit)
[![likes](https://img.shields.io/pub/likes/passkit)](https://pub.dev/packages/passkit/score)
[![popularity](https://img.shields.io/pub/popularity/passkit)](https://pub.dev/packages/passkit/score)
[![pub points](https://img.shields.io/pub/points/passkit)](https://pub.dev/packages/passkit/score)


[![Twitter Follow](https://img.shields.io/twitter/follow/ue_man?style=social)](https://twitter.com/ue_man)
[![GitHub followers](https://img.shields.io/github/followers/ueman?style=social)](https://github.com/ueman)

> 🚧 API is subject to change! 🚧

PassKit allows you to work with Apple's PkPass and Order files. This is a pure Dart library and works in Flutter, on the web and on servers. No Flutter needed.

In order to show PassKit and Order files in Flutter, use the [`passkit_ui`](https://pub.dev/packages/passkit_ui) package, which includes ready made widgets.

Want to work with Apple's native PassKit APIs? Consider using [`apple_passkit`](https://pub.dev/packages/apple_passkit).

## Table of Content

- [Passes](#passes)
- [Orders](#orders)

# Passes

## What is PassKit?

> Passes are a digital representation of information that might otherwise be printed on small pieces of paper or plastic. They let users take an action in the physical world. Passes can contain images and a barcode, and you can update passes using push notifications on iOS.
>
> This technology consists of three main components:
> - A package format for creating passes.
> - A web service API for updating passes, implemented on your server.
> - An API used by your apps to interact with the user’s pass library.

A PkPass file looks something like this when rendered in the iOS  Wallet app or via [`passkit_ui`](https://pub.dev/packages/passkit_ui):

<p align="center">
  <img src="https://raw.githubusercontent.com/ueman/passkit/master/passkit/assets/boarding_pass.webp"/>
</p>

## How to read a PassKit file?

```dart
import 'package:passkit/passkit.dart';

void main() {
  final passKitBytes = ... // get bytes for the PassKit from somewhere
  final pkPass = PkPass.fromBytes(passKitBytes);
}
```

## How to get the latest version of a given PkPass?

```dart
import 'package:passkit/passkit.dart';

void main() {
  final passKitBytes = ... // get bytes for the PassKit from somewhere
  final pkPass = PkPass.fromBytes(passKitBytes);

  if(pkPass.isWebServiceAvailable) {
    final pkPassBytes = PassKitWebClient().getLatestVersion(pkPass);
  }
}
```

## How to write a PassKit file?

> [!WARNING]
> This is experimental.
> The resulting file not yet get accepted by Apple Wallet due to missing support for writing the pass signature.

```dart
import 'package:passkit/passkit.dart';

void main() {
  final pkPass = PkPass(...);
  final pkPassFile = pass.write();
  await File('path/to/pass.pkpass').writeAsBytes(pkPassFile);
}
```

## Signature & Checksums

In case iOS runs into an issue with a PkPass it just shows a generic error message. This library is able to point out a more specific error, if a PkPass is malformatted, signed, or whatever.

Due to the closed source nature of the Apple Wallet software, there might be slight differences in this how the Wallet app and this package are working. If you run into such a problem, please create an issue.

## Apple Wallet PassKit docs

- [Wallet Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/wallet)
- [Wallet Passes](https://developer.apple.com/documentation/walletpasses/)
- [Loyalty passes](https://developer.apple.com/wallet/loyalty-passes/)
- [Wallet Developer Guide](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/index.html#//apple_ref/doc/uid/TP40012195-CH1-SW1)

# Orders

## What is order tracking?

> When you support order tracking, Wallet can display information about an order a customer placed through your app or website, updating the information whenever the status of the order changes. You can help people start tracking their order right from your app or website and offer additional ways to add their order to Wallet.

When rendered, orders look something like this in the iOS Wallet app or via [`passkit_ui`](https://pub.dev/packages/passkit_ui):

<p align="center">
  <img src="https://raw.githubusercontent.com/ueman/passkit/master/passkit/assets/order_tracking.png"/>
</p>

## How to read an order file?

```dart
import 'package:passkit/passkit.dart';

void main() {
  final orderBytes = ... // get bytes for the PassKit from somewhere
  final order = PkOrder.fromBytes(orderBytes);
}
```

## Apple Order Tracking docs

- [Order Tracking Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/wallet#Order-tracking)
- [Order Tracking](https://developer.apple.com/documentation/walletorders)
- [Order Tracking Demo](https://applepaydemo.apple.com/order-tracking)

# Closing notes

## Unsupported or experimental functionality

Please feel encouraged to create PRs for the following features.

- PassKit Web Service: This functionality is existing, but might not work. Please file an issue or create a PR with a fix for bugs you encounter.
  - Push Notification update registration is only working on iOS due to this whole specification being an Apple thingy.
- Localization: Existing, but still inconvenient to use. There might be issues due to localizations being UTF-16 formatted, but the library currently uses UTF-8 to read localizations.
- [Passkit creation](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW54) is partially supported. See note further above.

## Bugs and parsing issues

If you hit an issue with parsing, please create an issue and attach the pass or order file if possible.

## Contributors

Thanks a lot to all the awesome contributors:

<a href="https://github.com/ueman/passkit/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=ueman/passkit" />
</a>

Contribute to this library, and you'll show up too.

We encourage you to contribute to this library.
A good starting point is to look at these [good first issues](https://github.com/ueman/passkit/issues?q=is%3Aopen+is%3Aissue+label%3A%22package%3A+passkit%22+label%3A%22good+first+issue%22). Take a look at [these issues](https://github.com/ueman/passkit/issues?q=is%3Aopen+is%3Aissue+label%3A%22package%3A+passkit%22)
if you're up for a challenge.
