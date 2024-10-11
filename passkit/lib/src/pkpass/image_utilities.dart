import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:passkit/src/pk_image.dart';

/*
The pass layout allots a certain area on the front of the pass for each image. 
Images are scaled (preserving aspect ratio) to fill this allotted space. 
Images with a different aspect ratio than their allotted space are cropped after
being scaled. The space allotted is as follows:

- The background image (background.png) is displayed behind the entire front of
  the pass. The expected dimensions are 180 x 220 points. The image is cropped
  slightly on all sides and blurred. Depending on the image, you can often 
  provide an image at a smaller size and let it be scaled up, because the blur
  effect hides details. This lets you reduce the file size without a noticeable
  difference in the pass.

- The strip image (strip.png) is displayed behind the primary fields.
  - On iPhone 6 and 6 Plus The allotted space is 375 x 98 points for event tickets,
    375 x 144 points for gift cards and coupons, and 375 x 123 in all other cases.
  - On prior hardware The allotted space is 320 x 84 points for event tickets,
    320 x 110 points for other pass styles with a square barcode on devices with
    3.5 inch screens, and 320 x 123 in all other cases.

- The thumbnail image (thumbnail.png) displayed next to the fields on the front
  of the pass. The allotted space is 90 x 90 points. The aspect ratio should be
  in the range of 2:3 to 3:2, otherwise the image is cropped.

Note

The dimensions given above are all in points. On a non-Retina display, each 
point equals exactly 1 pixel. On a Retina display, there are 2 or 3 pixels per
point, depending on the device. To support all screen sizes and resolutions, 
provide the original, @2x, and @3x versions of your art.

Source https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html
*/

/// Creates all three image scales for the icon.
/// If you have localized images, you'll need to call this for every language.
///
/// The icon is displayed when a pass is shown on the lock screen and
/// by apps such as Mail when showing a pass attached to an email.
/// The icon should measure
/// - 29 * 29 at 1x
/// - 58 * 58 at 2x
/// - 87 * 87 at 3x
PkImage createIcon(Uint8List data) {
  final image = img.decodeImage(data);
  if (image == null) {
    throw Exception('Image could not be read');
  }
  assert(image.width == image.height, 'Image must be square');

  final images = <Uint8List>[];
  for (var i = 1; i <= 3; i++) {
    final resized = img.copyResize(
      image,
      width: 29 * i,
      height: 29 * i,
      interpolation: img.Interpolation.cubic,
    );
    images.add(img.encodePng(resized));
  }

  return PkImage(
    image1: images[0],
    image2: images[1],
    image3: images[2],
  );
}

/// Creates all three logo scales for the icon.
/// If you have localized images, you'll need to call this for every language.
///
/// The logo image is displayed in the top left corner of the pass,
/// next to the logo text.
/// The allotted space is 160 x 50 points; in most cases it should be narrower.
///
/// The logo should measure at max
/// - 160 * 50 at 1x
/// - 320 * 100 at 2x
/// - 480 * 150 at 3x
PkImage createLogo(Uint8List data) {
  final image = img.decodeImage(data);
  if (image == null) {
    throw Exception('Image could not be read');
  }

  final images = <Uint8List>[];
  for (var i = 1; i <= 3; i++) {
    final resized = img.copyResize(
      image,
      height: 50 * i,
      interpolation: img.Interpolation.cubic,
      maintainAspect: true,
    );
    images.add(img.encodePng(resized));
  }

  return PkImage(
    image1: images[0],
    image2: images[1],
    image3: images[2],
  );
}

/// Creates all three logo scales for the icon.
/// If you have localized images, you'll need to call this for every language.
///
/// The footer image (footer.png) is displayed near the barcode.
/// The allotted space is:
/// - 286 x 15 points at 1x
/// - 572 x 30 points at 2x
/// - 858 x 45 points at 3x
PkImage createFooter(Uint8List data) {
  final image = img.decodeImage(data);
  if (image == null) {
    throw Exception('Image could not be read');
  }
  assert(image.height % 15 == 0);
  assert(image.width % 286 == 0);

  final images = <Uint8List>[];
  for (var i = 1; i <= 3; i++) {
    final resized = img.copyResize(
      image,
      height: 15 * i,
      width: 286 * i,
      interpolation: img.Interpolation.cubic,
      maintainAspect: true,
    );
    images.add(img.encodePng(resized));
  }

  return PkImage(
    image1: images[0],
    image2: images[1],
    image3: images[2],
  );
}

/*

/// Background data should be 375 x 123, or a multiple of that
// 375, 750, 1125
// 123, 246, 369
// 184 ->
// 225
//
//
//   11px |
//  168px O-O-O-O-O- .... spacing 40
//   11px |
//  168px O
//   11px |
// =369px
PkImage createStampCartStrip(
  Uint8List backgroundData,
  Uint8List stampData,
  Uint8List stampFilledData,
) {
  final background = img.decodeImage(backgroundData)!;

  final stamp = img.decodeImage(stampData)!;
  assert(stamp.width == stamp.height, 'Image must be square');

  final stampFilled = img.decodeImage(stampFilledData)!;
  assert(stampFilled.width == stampFilled.height, 'Image must be square');

  final images = <Uint8List>[];
  for (var i = 1; i <= 3; i++) {
    final resized = img.copyResize(
      image,
      height: 123 * i,
      width: 375 * i,
      interpolation: img.Interpolation.cubic,
      maintainAspect: true,
    );
    images.add(img.encodePng(resized));
  }

  return PkImage(
    image1: images[0],
    image2: images[1],
    image3: images[2],
  );
}

*/
