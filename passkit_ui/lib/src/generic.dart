import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/theme/generic_pass_theme.dart';

/// https://developer.apple.com/design/human-interface-guidelines/wallet#Generic-passes
class Generic extends StatelessWidget {
  const Generic({super.key, required this.pass});

  final PkPass pass;

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    final passTheme = Theme.of(context).extension<GenericPassTheme>()!;
    final generic = pass.pass.generic!;

    return ClipPath(
      clipper: const ShapeBorderClipper(
        shape: ContinuousRectangleBorder(
          // TODO(any): put this into the theme
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      child: ColoredBox(
        color: passTheme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Logo(logo: pass.logo),
                  if (pass.pass.logoText != null)
                    Text(
                      pass.pass.logoText!,
                      style: passTheme.logoTextStyle,
                    ),
                  const Spacer(),
                  // TODO(ueman): The header should be as wide as the thumbnail
                  Column(
                    children: [
                      Text(
                        generic.headerFields?.first.label ?? '',
                        style: passTheme.headerLabelStyle,
                      ),
                      Text(
                        generic.headerFields?.first.value?.toString() ?? '',
                        style: passTheme.headerTextStyle,
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
                      width: 90,
                      height: 90,
                      fit: BoxFit.contain,
                      pass.thumbnail!.forCorrectPixelRatio(devicePixelRatio),
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
                  pass.footer!.forCorrectPixelRatio(devicePixelRatio),
                  fit: BoxFit.contain,
                  width: 286,
                  height: 15,
                ),
              if ((pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode) !=
                  null)
                PasskitBarcode(
                  barcode:
                      (pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode)!,
                  fontSize: 11,
                ),
            ],
          ),
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
  final GenericPassTheme passTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: auxiliaryRow.map((item) {
        return Column(
          children: [
            Text(
              item.label ?? '',
              style: passTheme.secondaryWithStripLabelStyle,
              textAlign: item.textAlignment.toFlutterTextAlign(),
            ),
            Text(
              item.formatted() ?? '',
              style: passTheme.secondaryWithStripTextStyle,
              textAlign: item.textAlignment.toFlutterTextAlign(),
            ),
          ],
        );
      }).toList(),
    );
  }
}
