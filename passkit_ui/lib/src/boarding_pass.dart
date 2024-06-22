import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:collection/collection.dart';
import 'package:passkit_ui/src/extension/formatting_extensions.dart';
import 'package:passkit_ui/src/extension/pk_pass_image_extensions.dart';
import 'package:passkit_ui/src/pass_theme.dart';
import 'package:passkit_ui/src/widgets/footer.dart';
import 'package:passkit_ui/src/widgets/passkit_barcode.dart';
import 'package:passkit_ui/src/widgets/transit_types/transit_type_widget.dart';

/// A boarding pass looks like the following:
///
/// ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Art/boarding_pass_2x.png)
/// ![](https://www.apple.com/v/wallet/d/images/overview/boarding_pass__f5z923n6wtay_medium_2x.png)
///
/// It supports the following images:
/// - logo
/// - icon
/// - footer
///
/// For more information see
/// - https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1
/// - https://developer.apple.com/design/human-interface-guidelines/wallet
class BoardingPass extends StatelessWidget {
  const BoardingPass({super.key, required this.pass});

  final PkPass pass;

  @override
  Widget build(BuildContext context) {
    final passTheme = pass.toTheme();
    final boardingPass = pass.pass.boardingPass!;

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
                SizedBox(width: 8),
                if (pass.pass.logoText != null)
                  Text(
                    pass.pass.logoText!,
                    style: passTheme.foregroundTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      boardingPass.headerFields!.first.label ?? '',
                      style: passTheme.labelTextStyle,
                    ),
                    Text(
                      boardingPass.headerFields!.first.value.toString(),
                      style: passTheme.foregroundTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _FromTo(
                  data: boardingPass.primaryFields!.first,
                  passTheme: passTheme,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TransitTypeWidget(
                    transitType: boardingPass.transitType,
                    width: 40,
                    height: 40,
                    color: passTheme.foregroundColor,
                  ),
                ),
                _FromTo(
                  data: boardingPass.primaryFields![1],
                  passTheme: passTheme,
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (boardingPass.auxiliaryFields != null)
              _AuxiliaryRow(
                auxiliaryRow: pass.pass.boardingPass!.auxiliaryFields!,
                passTheme: passTheme,
              ),
            const SizedBox(height: 16),
            // secondary fields
            Text(
              boardingPass.secondaryFields!.first.label ?? '',
              style: passTheme.labelTextStyle,
              textAlign: boardingPass.secondaryFields!.first.textAlignment
                  ?.flutterTextAlign(context),
            ),
            Text(
              boardingPass.secondaryFields!.first.value.toString(),
              style: passTheme.foregroundTextStyle,
              textAlign: boardingPass.secondaryFields!.first.textAlignment
                  ?.flutterTextAlign(context),
            ),
            const SizedBox(height: 16),
            Footer(footer: pass.footer),
            if ((pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode) != null)
              PasskitBarcode(
                barcode:
                    (pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode)!,
                passTheme: passTheme,
              ),

            if (pass.icon != null)
              // TODO check whether this matches Apples design guidelines
              Image.memory(
                pass.icon!.forCorrectPixelRatio(context),
                fit: BoxFit.contain,
                height: 15,
              )
          ],
        ),
      ),
    );
  }
}

class _FromTo extends StatelessWidget {
  const _FromTo({
    required this.data,
    required this.passTheme,
  });

  final FieldDict data;
  final PassTheme passTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          data.label ?? '',
          style: TextStyle(
            color: passTheme.labelColor,
            fontSize: 12,
          ),
        ),
        Text(
          data.value.toString(),
          style: TextStyle(
            color: passTheme.foregroundColor,
            fontSize: 40,
          ),
        ),
      ],
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
