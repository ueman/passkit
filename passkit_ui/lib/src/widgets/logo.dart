import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/extension/pk_pass_image_extensions.dart';

/// The logo image (`logo.png`) is displayed in the top left corner of the pass,
/// next to the logo text. The allotted space is 160 x 50 points;
/// in most cases it should be narrower.
///
/// Images are scaled (preserving aspect ratio) to fill this allotted space.
/// Images with a different aspect ratio than their allotted space are cropped
/// after being scaled.
class Logo extends StatelessWidget {
  const Logo({super.key, this.logo});

  final PkPassImage? logo;

  @override
  Widget build(BuildContext context) {
    final logoImage = logo;
    if (logoImage != null) {
      return FittedBox(
        clipBehavior: Clip.hardEdge,
        child: Image.memory(
          logoImage.forCorrectPixelRatio(context),
          fit: BoxFit.cover,
          width: 160,
          height: 50,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
