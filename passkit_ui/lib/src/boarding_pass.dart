import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/theme/theme.dart';

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
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    final passTheme = pass.theme;
    final boardingPass = pass.pass.boardingPass!;

    return Card(
      color: passTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
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
                    pass.logo!.forCorrectPixelRatio(devicePixelRatio),
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 8),
                if (pass.pass.logoText != null)
                  // Should match the Headline text style from here for medium size devices
                  // https://developer.apple.com/design/human-interface-guidelines/typography
                  // Fontweight semibold (w600), font size 16
                  Text(
                    pass.pass.logoText!,
                    style: passTheme.foregroundTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Should match the Headline text style from here for medium size devices
                    // https://developer.apple.com/design/human-interface-guidelines/typography
                    // Fontweight semibold (w600), font size 16
                    Text(
                      boardingPass.headerFields!.first.label ?? '',
                      style: passTheme.labelTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      boardingPass.headerFields!.first.value.toString(),
                      style: passTheme.foregroundTextStyle.copyWith(
                        fontSize: 19,
                        height: 0.9,
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
                  data: boardingPass.primaryFields!.first,
                  passTheme: passTheme,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
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
            _AuxiliaryRow(
              auxiliaryRow: pass.pass.boardingPass!.secondaryFields!,
              passTheme: passTheme,
            ),

            const SizedBox(height: 16),
            Footer(footer: pass.footer),
            const SizedBox(height: 2),
            if ((pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode) != null)
              PasskitBarcode(
                barcode:
                    (pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode)!,
                passTheme: passTheme,
              ),

            if (pass.icon != null)
              // TODO(ueman): check whether this matches Apples design guidelines
              Image.memory(
                pass.icon!.forCorrectPixelRatio(devicePixelRatio),
                fit: BoxFit.contain,
                height: 15,
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
    required this.crossAxisAlignment,
  });

  final FieldDict data;
  final PassTheme passTheme;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          data.label ?? '',
          style: TextStyle(
            color: passTheme.labelColor,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          data.value.toString(),
          style: TextStyle(
            color: passTheme.foregroundColor,
            fontSize: 40,
            height: 0.9,
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
    final directionality = Directionality.of(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...auxiliaryRow.map(
          (item) => Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  item.label ?? '',
                  style: passTheme.labelTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: item.textAlignment?.toFlutterTextAlign(
                    textDirection: directionality,
                  ),
                ),
                Text(
                  item.value.toString(),
                  style: passTheme.foregroundTextStyle.copyWith(
                    fontSize: 16,
                    height: 0.9,
                  ),
                  textAlign: item.textAlignment?.toFlutterTextAlign(
                    textDirection: directionality,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
