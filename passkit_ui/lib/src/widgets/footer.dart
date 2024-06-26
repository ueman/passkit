import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/extensions/pk_pass_image_extension.dart';

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
    if (footer == null) return const SizedBox.shrink();

    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    return Image.memory(
      footer!.forCorrectPixelRatio(devicePixelRatio),
      fit: BoxFit.contain,
      width: 286,
      height: 15,
    );
  }
}
