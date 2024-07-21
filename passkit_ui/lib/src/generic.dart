import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/theme/generic_pass_theme.dart';
import 'package:passkit_ui/src/widgets/header_row.dart';
import 'package:passkit_ui/src/widgets/thumbnail.dart';

/// https://developer.apple.com/design/human-interface-guidelines/wallet#Generic-passes
class Generic extends StatelessWidget {
  const Generic({super.key, required this.pass});

  final PkPass pass;

  @override
  Widget build(BuildContext context) {
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
              HeaderRow(
                passTheme: passTheme,
                headerFields: generic.headerFields,
                logo: pass.logo,
                logoText: pass.pass.logoText,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _AuxiliaryRow(
                      passTheme: passTheme,
                      auxiliaryRow: generic.primaryFields!,
                      primary: true,
                    ),
                  ),
                  // The thumbnail image (`thumbnail.png`) displayed next to the
                  // fields on the front of the pass. The allotted space is
                  // 90 x 90 points. The aspect ratio should be in the range of
                  // 2:3 to 3:2, otherwise the image is cropped.
                  Thumbnail(thumbnail: pass.thumbnail),
                ],
              ),
              if (generic.secondaryFields != null)
                _AuxiliaryRow(
                  passTheme: passTheme,
                  auxiliaryRow: generic.secondaryFields!,
                  primary: false,
                ),
              if (generic.auxiliaryFields != null) ...[
                const SizedBox(height: 16),
                _AuxiliaryRow(
                  passTheme: passTheme,
                  auxiliaryRow: generic.auxiliaryFields!,
                  primary: false,
                ),
              ],
              const Spacer(),
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
    required this.primary,
  });

  final List<FieldDict> auxiliaryRow;
  final GenericPassTheme passTheme;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: auxiliaryRow.map((item) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                item.label ?? '',
                style: primary
                    ? passTheme.primaryWithThumbnailLabelStyle
                    : passTheme.secondaryWithThumbnailLabelStyle,
                textAlign: item.textAlignment.toFlutterTextAlign(),
              ),
              Text(
                item.formatted() ?? '',
                style: primary
                    ? passTheme.primaryWithThumbnailTextStyle
                    : passTheme.secondaryWithThumbnailTextStyle,
                textAlign: item.textAlignment.toFlutterTextAlign(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
