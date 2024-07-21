import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/extensions/pk_pass_image_extension.dart';

/// The thumbnail image (thumbnail.png) displayed next to the fields on the
/// front of the pass. The allotted space is 90 x 90 points. The aspect ratio
/// should be in the range of 2:3 to 3:2, otherwise the image is cropped.
///
/// From https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW8
class Thumbnail extends StatelessWidget {
  const Thumbnail({super.key, this.thumbnail});

  final PkPassImage? thumbnail;

  @override
  Widget build(BuildContext context) {
    if (thumbnail == null) return const SizedBox.shrink();

    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    return Image.memory(
      thumbnail!.forCorrectPixelRatio(devicePixelRatio),
      fit: BoxFit.contain,
      width: 90,
      height: 90,
    );
  }
}
