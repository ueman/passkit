# passkit_ui

[![pub package](https://img.shields.io/pub/v/passkit_ui.svg)](https://pub.dev/packages/passkit_ui)
[![likes](https://img.shields.io/pub/likes/passkit_ui)](https://pub.dev/packages/passkit_ui/score)
[![popularity](https://img.shields.io/pub/popularity/passkit_ui)](https://pub.dev/packages/passkit_ui/score)
[![pub points](https://img.shields.io/pub/points/passkit_ui)](https://pub.dev/packages/passkit_ui/score)

[![Twitter Follow](https://img.shields.io/twitter/follow/ue_man?style=social)](https://twitter.com/ue_man)
[![GitHub followers](https://img.shields.io/github/followers/ueman?style=social)](https://github.com/ueman)

> 🚧 API is subject to change! 🚧
> Not all pass types are yet supported. Not ready for production use.

## What is PassKit?

> Passes are a digital representation of information that might otherwise be printed on small pieces of paper or plastic. They let users take an action in the physical world. Passes can contain images and a barcode, and you can update passes using push notifications on iOS.
>
> This technology consists of three main components:
> - A package format for creating passes.
> - A web service API for updating passes, implemented on your server.
> - An API used by your apps to interact with the user’s pass library.

A PkPass file looks something like this when rendered:

<p align="center">
  <img src="https://raw.githubusercontent.com/ueman/passkit/master/passkit_ui/assets/boarding_pass.png" height="400"/>
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

## Contributors

Thanks a lot to all the awesome contributors:

<a href="https://github.com/ueman/passkit/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=ueman/passkit" />
</a>

Contribute to this library, and you'll show up too.

We encourage you to contribute to this library.
A good starting point is to look at these [good first issues](https://github.com/ueman/passkit/issues?q=is%3Aopen+is%3Aissue+label%3A%22package%3A+passkit_ui%22+label%3A%22good+first+issue%22). Take a look at [these issues](https://github.com/ueman/passkit/issues?q=is%3Aopen+is%3Aissue+label%3A%22package%3A+passkit_ui%22)
if you're up for a challenge.

# Development related docs

Design docs: 
- https://developer.apple.com/design/human-interface-guidelines/wallet
- https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1


## Image docs

Taken from [here](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1).

# Images Fill Their Allotted Space
The pass layout allots a certain area on the front of the pass for each image. Images are scaled (preserving aspect ratio) to fill this allotted space. Images with a different aspect ratio than their allotted space are cropped after being scaled. The space allotted is as follows:

- The background image (`background.png`) is displayed behind the entire front of the pass. The expected dimensions are 180 x 220 points. The image is cropped slightly on all sides and blurred. Depending on the image, you can often provide an image at a smaller size and let it be scaled up, because the blur effect hides details. This lets you reduce the file size without a noticeable difference in the pass.
- The footer image (`footer.png`) is displayed near the barcode. The allotted space is 286 x 15 points.
- The icon (`icon.png`) is displayed when a pass is shown on the lock screen and by apps such as Mail when showing a pass attached to an email. The icon should measure 29 x 29 points.
- The logo image (`logo.png`) is displayed in the top left corner of the pass, next to the logo text. The allotted space is 160 x 50 points; in most cases it should be narrower.
- The strip image (`strip.png`) is displayed behind the primary fields.
  - **On iPhone 6 and 6 Plus** The allotted space is 375 x 98 points for event tickets, 375 x 144 points for gift cards and coupons, and 375 x 123 in all other cases.
  - **On prior hardware** The allotted space is 320 x 84 points for event tickets, 320 x 110 points for other pass styles with a square barcode on devices with 3.5 inch screens, and 320 x 123 in all other cases.
- The thumbnail image (`thumbnail.png`) displayed next to the fields on the front of the pass. The allotted space is 90 x 90 points. The aspect ratio should be in the range of 2:3 to 3:2, otherwise the image is cropped.

> [!NOTE ]The dimensions given above are all in points. On a non-Retina display, each point equals exactly 1 pixel. On a Retina display, there are 2 or 3 pixels per point, depending on the device. To support all screen sizes and resolutions, provide the original, @2x, and @3x versions of your art.
