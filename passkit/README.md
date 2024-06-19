# PassKit

PassKit allows you to work with Apple's PkPass files. This is a pure Dart library. No Flutter needed.

## How to read a PassKit file?

```dart
import 'package:passkit/passkit.dart';

void main() {
  final passKitBytes = ... // get bytes for the PassKit from somewhere
  final pkPass = PkPass.fromBytes(passKitBytes);
}
```

## Currently unsupported functionality

Feel free to submit PRs for them

- Semantic Tags: https://developer.apple.com/documentation/passkit/wallet/supporting_semantic_tags_in_wallet_passes
- PassKit Web Service: https://developer.apple.com/library/archive/documentation/PassKit/Reference/PassKit_WebService/WebService.html#//apple_ref/doc/uid/TP40011988
- Localization: https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW54 (as seen at the bottom of the page)
    - .strings file format description https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/LoadingResources/Strings/Strings.html
- Passkit creation: https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW54 (as seen at the bottom of the page)
