# Apple PassKit

This is Flutter binding for [Apple's PassKit](https://developer.apple.com/documentation/passkit).

Right now, this library allows you to check whether your app is able to deal with passes at all, whether your app can add passes, and then of course it also allows you to add passes.


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

Setup your Xcode project in accordance of the [documentation](https://help.apple.com/xcode/mac/current/#/devfc3f493bb).

After that, use `ApplePassKit().passes()` to load your installed passes. 
Use [https://pub.dev/packages/passkit](`package:passkit`) to compare them to `.pkpass` files.