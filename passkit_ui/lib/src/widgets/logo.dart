import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/extensions/pk_pass_image_extension.dart';

/// The logo image (`logo.png`) is displayed in the top left corner of the pass,
/// next to the logo text. The allotted space is 160 x 50 points;
/// in most cases it should be narrower.
///
/// Images are scaled (preserving aspect ratio) to fill this allotted space.
/// Images with a different aspect ratio than their allotted space are cropped
/// after being scaled.
class Logo extends StatelessWidget {
  const Logo({super.key, this.logo});

  final PkImage? logo;

  @override
  Widget build(BuildContext context) {
    if (logo == null) return const SizedBox.shrink();

    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 30,
        maxHeight: 30,
        maxWidth: 96,
      ),
      child: Image.memory(
        logo!.forCorrectPixelRatio(devicePixelRatio),
        fit: BoxFit.contain,
      ),
    );
  }
}
