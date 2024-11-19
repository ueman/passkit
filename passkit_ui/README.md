# passkit_ui

[![pub package](https://img.shields.io/pub/v/passkit_ui.svg)](https://pub.dev/packages/passkit_ui)
[![likes](https://img.shields.io/pub/likes/passkit_ui)](https://pub.dev/packages/passkit_ui/score)
[![popularity](https://img.shields.io/pub/popularity/passkit_ui)](https://pub.dev/packages/passkit_ui/score)
[![pub points](https://img.shields.io/pub/points/passkit_ui)](https://pub.dev/packages/passkit_ui/score)

[![Twitter Follow](https://img.shields.io/twitter/follow/ue_man?style=social)](https://twitter.com/ue_man)
[![GitHub followers](https://img.shields.io/github/followers/ueman?style=social)](https://github.com/ueman)
[![Bluesky Follow](https://img.shields.io/badge/Follow%20on%20Bluesky-08f)](https://bsky.app/profile/uekoetter.dev)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-30363D?style=flat&logo=GitHub-Sponsors&logoColor=#EA4AAA)](https://github.com/sponsors/ueman)

> 🚧 API is subject to change! 🚧
> All passkit types can be shown, but might not look perfect.
> Please create an issue and attach a sample PkPass file for wrongly displayed passes.

## What is PassKit?

> Passes are a digital representation of information that might otherwise be printed on small pieces of paper or plastic. They let users take an action in the physical world. Passes can contain images and a barcode, and you can update passes using push notifications on iOS.
>
> This technology consists of three main components:
> - A package format for creating passes.
> - A web service API for updating passes, implemented on your server.
> - An API used by your apps to interact with the user’s pass library.

A PkPass file looks something like this when rendered:

<p align="center">
  <img src="https://raw.githubusercontent.com/ueman/passkit/master/passkit_ui/assets/boarding_pass.webp" />
</p>

This package contains widgets to visualize `PkPass` files as seen above with the help of [`passkit`](https://pub.dev/packages/passkit). `passkit` is a pure Dart package, which works on servers, too.

This package does intentionally not support showing the "backside" of a `PkPass` file, since that requires a lot of features that depend on application logic.
Those include, among other things: sharing a pass, deleting a pass, having the ability to open URLs, emails and phone numbers.

You want to work with Apple's native PassKit APIs? Consider using [`apple_passkit`](https://pub.dev/packages/apple_passkit) in addition to this.

## How to use it?

Add the `passkit` and `passkit_ui` packages to your `pubspec.yaml` file

```yaml
dependencies:
  passkit: any # Use the latest available version
  passkit_ui: any # Use the latest available version
```

Use it in your code:

```dart
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

// First load the PkPass file somewhere
final pkPass = await loadPass('assets/coupon.pkpass')

// Then in your widget, use the `PkPassWidget` and pass the PkPass to it
Center(child: PkPassWidget(pass: pkPass))
```

## Apple Wallet PassKit docs

- [Wallet Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/wallet)
- [Wallet Passes](https://developer.apple.com/documentation/walletpasses/)
- [Loyalty passes](https://developer.apple.com/wallet/loyalty-passes/)
- [Wallet Developer Guide](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/index.html#//apple_ref/doc/uid/TP40012195-CH1-SW1)

## Contributors

Thanks a lot to all the awesome contributors:

<a href="https://github.com/ueman/passkit/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=ueman/passkit" />
</a>

Contribute to this library, and you'll show up too.

We encourage you to contribute to this library.
A good starting point is to look at these [good first issues](https://github.com/ueman/passkit/issues?q=is%3Aopen+is%3Aissue+label%3A%22package%3A+passkit_ui%22+label%3A%22good+first+issue%22). Take a look at [these issues](https://github.com/ueman/passkit/issues?q=is%3Aopen+is%3Aissue+label%3A%22package%3A+passkit_ui%22)
if you're up for a challenge.

## Further references

- [Full Stack Dart with Apple Passkit, Dart Frog and Flutter](https://www.youtube.com/live/FUDhgGmygKM?si=4nIR7SOYTIwYNJP4&t=27233) in Spanish by [Marcos Sevilla](https://github.com/marcossevilla)
