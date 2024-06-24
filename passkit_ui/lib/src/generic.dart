import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/extension/pk_pass_image_extensions.dart';
import 'package:passkit_ui/src/extension/formatting_extensions.dart';
import 'package:passkit_ui/src/pass_theme.dart';
import 'package:passkit_ui/src/widgets/passkit_barcode.dart';

/// https://developer.apple.com/design/human-interface-guidelines/wallet#Generic-passes
class Generic extends StatelessWidget {
  const Generic({super.key, required this.pass});

  final PkPass pass;

  @override
  Widget build(BuildContext context) {
    final passTheme = pass.toTheme();
    final generic = pass.pass.generic!;

    return Card(
      color: passTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                /// The logo image (logo.png) is displayed in the top left corner
                /// of the pass, next to the logo text. The allotted space is
                /// 160 x 50 points; in most cases it should be narrower.
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 160,
                    maxHeight: 50,
                  ),
                  child: Image.memory(
                    pass.logo!.forCorrectPixelRatio(context),
                    fit: BoxFit.contain,
                  ),
                ),
                if (pass.pass.logoText != null)
                  Text(
                    pass.pass.logoText!,
                    style: passTheme.foregroundTextStyle,
                  ),
                const Spacer(),
                // TODO(ueman): The header should be as wide as the thumbnail
                Column(
                  children: [
                    Text(
                      generic.headerFields?.first.label ?? '',
                      style: passTheme.labelTextStyle,
                    ),
                    Text(
                      generic.headerFields?.first.value?.toString() ?? '',
                      style: passTheme.foregroundTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AuxiliaryRow(
                  passTheme: passTheme,
                  auxiliaryRow: generic.primaryFields!,
                ),
                // The thumbnail image (`thumbnail.png`) displayed next to the
                // fields on the front of the pass. The allotted space is
                // 90 x 90 points. The aspect ratio should be in the range of
                // 2:3 to 3:2, otherwise the image is cropped.
                if (pass.thumbnail != null)
                  Image.memory(
                    pass.thumbnail!.forCorrectPixelRatio(context),
                  ),
              ],
            ),
            if (generic.secondaryFields != null)
              _AuxiliaryRow(
                passTheme: passTheme,
                auxiliaryRow: generic.secondaryFields!,
              ),
            if (generic.auxiliaryFields != null) ...[
              const SizedBox(height: 16),
              _AuxiliaryRow(
                passTheme: passTheme,
                auxiliaryRow: generic.auxiliaryFields!,
              ),
            ],
            const SizedBox(height: 16),
            if (pass.footer != null)
              Image.memory(
                pass.footer!.forCorrectPixelRatio(context),
                fit: BoxFit.contain,
                width: 286,
                height: 15,
              ),
            if ((pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode) != null)
              PasskitBarcode(
                barcode:
                    (pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode)!,
                passTheme: passTheme,
              ),
          ],
        ),
      ),
    );
  }
}

class _AuxiliaryRow extends StatelessWidget {
  const _AuxiliaryRow({
    required this.auxiliaryRow,
    required this.passTheme,
  });

  final List<FieldDict> auxiliaryRow;
  final PassTheme passTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: auxiliaryRow.map((item) {
        return Column(
          children: [
            Text(
              item.label ?? '',
              style: passTheme.labelTextStyle,
              textAlign: item.textAlignment?.flutterTextAlign(context),
            ),
            Text(
              item.value.toString(),
              style: passTheme.foregroundTextStyle,
              textAlign: item.textAlignment?.flutterTextAlign(context),
            ),
          ],
        );
      }).toList(),
    );
  }
}
