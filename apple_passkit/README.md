# Apple PassKit

[![pub package](https://img.shields.io/pub/v/apple_passkit.svg)](https://pub.dev/packages/apple_passkit)
[![likes](https://img.shields.io/pub/likes/apple_passkit)](https://pub.dev/packages/apple_passkit/score)
[![popularity](https://img.shields.io/pub/popularity/apple_passkit)](https://pub.dev/packages/apple_passkit/score)
[![pub points](https://img.shields.io/pub/points/apple_passkit)](https://pub.dev/packages/apple_passkit/score)


[![Twitter Follow](https://img.shields.io/twitter/follow/ue_man?style=social)](https://twitter.com/ue_man)
[![GitHub followers](https://img.shields.io/github/followers/ueman?style=social)](https://github.com/ueman)


This is a Flutter binding for [Apple's PassKit](https://developer.apple.com/documentation/passkit).

This library allows you to add `PkPass` files to the users' wallet.
It also allows you to read available `PkPass` files in your users' wallet.

Do you need to deal with `PkPass` files in your code, consider using 
[`passkit`](https://pub.dev/packages/passkit) and [`passkit_ui`](https://pub.dev/packages/passkit_ui) instead. Those do not depend on iOS/macOS and are mostly cross-platform.

## What is PassKit?

> Passes are a digital representation of information that might otherwise be printed on small pieces of paper or plastic. They let users take an action in the physical world. Passes can contain images and a barcode, and you can update passes using push notifications on iOS.

A PkPass file looks something like this when rendered:

<p align="center">
  <img src="https://raw.githubusercontent.com/ueman/passkit/master/apple_passkit/assets/boarding_pass.png" height="400"/>
</p>

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

To view all methods, take a look at the [API docs](https://pub.dev/documentation/apple_passkit/latest/apple_passkit/ApplePassKit-class.html).

## View your app's passes

Setup your Xcode project as described in the [documentation](https://help.apple.com/xcode/mac/current/#/devfc3f493bb).

After that, use `await ApplePassKit().passes()` to load your installed passes.

## Contributors

Thanks a lot to all the awesome contributors:

<a href="https://github.com/ueman/passkit/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=ueman/passkit" />
</a>

Contribute to this library, and you'll show up too.

We encourage you to contribute to this library.
A good starting point is to look at these [good first issues](https://github.com/ueman/passkit/issues?q=is%3Aopen+is%3Aissue+label%3A%22package%3A+apple_passkit%22+label%3A%22good+first+issue%22). Take a look at [these issues](https://github.com/ueman/passkit/issues?q=is%3Aopen+is%3Aissue+label%3A%22package%3A+apple_passkit%22)
if you're up for a challenge.
