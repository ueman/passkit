import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/extension/pk_pass_image_extensions.dart';

/// The footer image (`footer.png`) is displayed near the barcode.
/// The allotted space is 286 x 15 points.
/// Images are scaled (preserving aspect ratio) to fill this allotted space.
/// Images with a different aspect ratio than their allotted space are cropped
/// after being scaled.
class Footer extends StatelessWidget {
  const Footer({super.key, this.footer});

  final PkPassImage? footer;

  @override
  Widget build(BuildContext context) {
    final footerImage = footer;
    if (footerImage != null) {
      return FittedBox(
        clipBehavior: Clip.hardEdge,
        child: Image.memory(
          footerImage.forCorrectPixelRatio(context),
          fit: BoxFit.cover,
          width: 286,
          height: 15,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
