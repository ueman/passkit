# Apple PassKit

[![pub package](https://img.shields.io/pub/v/apple_passkit.svg)](https://pub.dev/packages/apple_passkit)
[![likes](https://img.shields.io/pub/likes/apple_passkit)](https://pub.dev/packages/apple_passkit/score)
[![popularity](https://img.shields.io/pub/popularity/apple_passkit)](https://pub.dev/packages/apple_passkit/score)
[![pub points](https://img.shields.io/pub/points/apple_passkit)](https://pub.dev/packages/apple_passkit/score)

This is a Flutter binding for [Apple's PassKit](https://developer.apple.com/documentation/passkit).

This library allows you to add and and read `PkPass` files.

## 📣 About the author

- [![Twitter Follow](https://img.shields.io/twitter/follow/ue_man?style=social)](https://twitter.com/ue_man)
- [![GitHub followers](https://img.shields.io/github/followers/ueman?style=social)](https://github.com/ueman)

## How to use it

```dart
final passKit = ApplePassKit();
// first check whether PassKit is available
bool isAvailable = await passKit.isPassLibraryAvailable();
// then check whether you can actually add passes
bool canAddPasses = await passKit.canAddPasses();

// when both of them are true, you can add a pass.
if(isAvailable && canAddPasses) {
    await passKit.addPass(pass);
}
```

# View your app's passes

Setup your Xcode project as described in the [documentation](https://help.apple.com/xcode/mac/current/#/devfc3f493bb).

After that, use `await ApplePassKit().passes()` to load your installed passes.
