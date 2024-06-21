# PassKit

[![pub package](https://img.shields.io/pub/v/passkit.svg)](https://pub.dev/packages/passkit)
[![likes](https://img.shields.io/pub/likes/passkit)](https://pub.dev/packages/passkit/score)
[![popularity](https://img.shields.io/pub/popularity/passkit)](https://pub.dev/packages/passkit/score)
[![pub points](https://img.shields.io/pub/points/passkit)](https://pub.dev/packages/passkit/score)


[![Twitter Follow](https://img.shields.io/twitter/follow/ue_man?style=social)](https://twitter.com/ue_man)
[![GitHub followers](https://img.shields.io/github/followers/ueman?style=social)](https://github.com/ueman)

PassKit allows you to work with Apple's PkPass files. This is a pure Dart library. No Flutter needed.

Want to work with Apple's PassKit APIs? Consider using [`apple_passkit`](https://pub.dev/packages/apple_passkit).

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

## Currently unsupported functionality

Feel free to submit PRs for them

- Semantic Tags: https://developer.apple.com/documentation/passkit/wallet/supporting_semantic_tags_in_wallet_passes
- PassKit Web Service: https://developer.apple.com/library/archive/documentation/PassKit/Reference/PassKit_WebService/WebService.html#//apple_ref/doc/uid/TP40011988
  - Partially supported
  - Push Notification related functionality can only work on iOS due to its [APN](https://en.wikipedia.org/wiki/Apple_Push_Notification_service) requirement (that's why it's not done yet)
- Localization: https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW54 (as seen at the bottom of the page)
    - .strings file format description https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/LoadingResources/Strings/Strings.html
- Passkit creation: https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW54 (as seen at the bottom of the page)
- checksum verification

## Bugs and parsing issues

If you hit an issue with parsing, please create an issue and attach the PkPass (if possible)