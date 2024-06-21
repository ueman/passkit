import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/pass_theme.dart';
import 'package:passkit_ui/src/widgets/backfields_dialog.dart';
import 'package:passkit_ui/src/widgets/transit_type_widget.dart';

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
    final pixelRatio = MediaQuery.devicePixelRatioOf(context).toInt();
    final passTheme = pass.toTheme();

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    pass.logo!.fromMultiplier(pixelRatio),
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  pass.pass.logoText!,
                  style: passTheme.foregroundTextStyle,
                ),
                Column(
                  children: [
                    Text(
                      pass.pass.boardingPass!.headerFields!.first.label ?? '',
                      style: passTheme.labelTextStyle,
                    ),
                    Text(
                      pass.pass.boardingPass!.headerFields!.first.value
                          .toString(),
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
                  data: pass.pass.boardingPass!.primaryFields!.first,
                  passTheme: passTheme,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TransitTypeWidget(
                    transitType: pass.pass.boardingPass!.transitType,
                    width: 40,
                    color: passTheme.foregroundColor,
                  ),
                ),
                _FromTo(
                  data: pass.pass.boardingPass!.primaryFields![1],
                  passTheme: passTheme,
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (pass.pass.boardingPass?.auxiliaryFields != null)
              _AuxiliaryRow(
                auxiliaryRow: pass.pass.boardingPass!.auxiliaryFields!,
                passTheme: passTheme,
              ),
            const SizedBox(height: 16),
            // secondary fields
            Text(
              pass.pass.boardingPass!.secondaryFields!.first.label ?? '',
              style: passTheme.labelTextStyle,
            ),
            Text(
              pass.pass.boardingPass!.secondaryFields!.first.value.toString(),
              style: passTheme.foregroundTextStyle,
            ),
            const SizedBox(height: 16),
            if (pass.footer != null)
              Image.memory(
                pass.footer!.fromMultiplier(pixelRatio),
                fit: BoxFit.contain,
                width: 286,
                height: 15,
              ),
            if (pass.pass.barcode != null)
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: BarcodeWidget(
                  width: 200,
                  height: 200,
                  barcode: pass.pass.barcode!.formatType,
                  data: pass.pass.barcode!.message,
                  drawText: true,
                ),
              ),
            if (pass.pass.barcode!.altText != null)
              Text(
                pass.pass.barcode!.altText!,
                style: passTheme.foregroundTextStyle,
              ),
            if (pass.pass.boardingPass?.backFields != null)
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () => showBackFieldsDialog(
                      context, pass.pass.boardingPass!.backFields!),
                  icon: Icon(
                    Icons.info_outline,
                    color: passTheme.foregroundColor,
                  ),
                ),
              ),
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
            ),
            Text(
              item.value.toString(),
              style: passTheme.foregroundTextStyle,
            ),
          ],
        );
      }).toList(),
    );
  }
}
