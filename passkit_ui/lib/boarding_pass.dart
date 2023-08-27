import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/widgets/plane_icon.dart';
import 'css_color_extension.dart';

/// A boarding pass looks like the following:
///
/// ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Art/boarding_pass_2x.png)
/// ![](https://www.apple.com/v/wallet/d/images/overview/boarding_pass__f5z923n6wtay_medium_2x.png)
///
/// It supports the follogin images:
/// - logo
/// - icon
/// - footer
///
/// For more information see
/// - https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1
class BoardingPass extends StatelessWidget {
  const BoardingPass({super.key, required this.pass});

  final PkPass pass;

  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio.toInt();
    return Card(
      color: pass.pass.backgroundColor?.toDartUiColor(),
      child: Column(
        children: [
          Row(
            children: [
              /// The logo image (logo.png) is displayed in the top left corner
              /// of the pass, next to the logo text. The allotted space is
              /// 160 x 50 points; in most cases it should be narrower.
              Image.memory(
                pass.logo!.fromMultiplier(pixelRatio),
                width: 160,
                height: 50,
                fit: BoxFit.contain,
              ),
              Text(
                pass.pass.logoText!,
                style: TextStyle(
                  color: pass.pass.foregroundColor?.toDartUiColor(),
                ),
              ),
              Column(
                children: [
                  Text(
                    pass.pass.boardingPass!.headerFields!.first.label ?? '',
                    style: TextStyle(
                      color: pass.pass.labelColor?.toDartUiColor(),
                    ),
                  ),
                  Text(
                    pass.pass.boardingPass!.headerFields!.first.value,
                    style: TextStyle(
                      color: pass.pass.foregroundColor?.toDartUiColor(),
                    ),
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
                foregroundColor: pass.pass.foregroundColor?.toDartUiColor(),
                labelColor: pass.pass.labelColor?.toDartUiColor(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PlaneIcon(
                  width: 40,
                  color: pass.pass.foregroundColor?.toDartUiColor() ??
                      Colors.black,
                ),
              ),
              _FromTo(
                data: pass.pass.boardingPass!.primaryFields![1],
                foregroundColor: pass.pass.foregroundColor?.toDartUiColor(),
                labelColor: pass.pass.labelColor?.toDartUiColor(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (pass.pass.boardingPass?.auxiliaryFields != null)
            _AuxiliaryRow(
              auxiliaryRow: pass.pass.boardingPass!.auxiliaryFields!,
              foregroundColor: pass.pass.foregroundColor?.toDartUiColor(),
              labelColor: pass.pass.labelColor?.toDartUiColor(),
            ),

          const SizedBox(height: 16),
          // secondary fields
          if (pass.footer != null)
            Image.memory(
              pass.footer!.fromMultiplier(pixelRatio),
              fit: BoxFit.contain,
              width: 286,
              height: 15,
            ),
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
              style:
                  TextStyle(color: pass.pass.foregroundColor?.toDartUiColor()),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _FromTo extends StatelessWidget {
  const _FromTo({
    required this.data,
    this.labelColor,
    this.foregroundColor,
  });

  final FieldDict data;
  final Color? labelColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          data.label ?? '',
          style: TextStyle(
            color: labelColor,
            fontSize: 12,
          ),
        ),
        Text(
          data.value,
          style: TextStyle(
            color: foregroundColor,
            fontSize: 40,
            //fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _AuxiliaryRow extends StatelessWidget {
  const _AuxiliaryRow({
    required this.auxiliaryRow,
    this.labelColor,
    this.foregroundColor,
  });

  final List<FieldDict> auxiliaryRow;

  final Color? labelColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: auxiliaryRow.map((item) {
        return Column(
          children: [
            Text(
              item.label ?? '',
              style: TextStyle(color: labelColor),
            ),
            Text(
              item.value,
              style: TextStyle(color: foregroundColor),
            ),
          ],
        );
      }).toList(),
    );
  }
}
