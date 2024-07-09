import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/theme/boarding_pass_theme.dart';
import 'package:passkit_ui/src/widgets/header_row.dart';

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
    final theme = Theme.of(context).extension<BoardingPassTheme>()!;
    final boardingPass = pass.pass.boardingPass!;

    return ColoredBox(
      color: theme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HeaderRow(
                  passTheme: theme,
                  logoText: pass.pass.logoText,
                  headerFields: boardingPass.headerFields,
                  logo: pass.logo,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _FromTo(
                      data: boardingPass.primaryFields!.first,
                      theme: theme,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TransitTypeWidget(
                        transitType: boardingPass.transitType,
                        width: 30,
                        height: 30,
                        color: theme.labelColor,
                      ),
                    ),
                    _FromTo(
                      data: boardingPass.primaryFields![1],
                      theme: theme,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (boardingPass.auxiliaryFields != null)
                  _AuxiliaryRow(
                    auxiliaryRow: pass.pass.boardingPass!.auxiliaryFields!,
                    theme: theme,
                  ),
                const SizedBox(height: 16),
                // secondary fields
                _AuxiliaryRow(
                  auxiliaryRow: pass.pass.boardingPass!.secondaryFields!,
                  theme: theme,
                ),

                const SizedBox(height: 16),
                if ((pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode) !=
                    null) ...[
                  const Spacer(),
                  Footer(footer: pass.footer),
                  const SizedBox(height: 2),
                  PasskitBarcode(
                    barcode:
                        (pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode)!,
                    fontSize: 12,
                  ),
                ],
              ],
            ),
            if (pass.icon != null)
              // TODO(ueman): check whether this matches Apples design guidelines
              Align(
                alignment: Alignment.bottomLeft,
                child: Image.memory(
                  pass.icon!.forCorrectPixelRatio(devicePixelRatio),
                  fit: BoxFit.contain,
                  height: 15,
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
    required this.theme,
    required this.crossAxisAlignment,
  });

  final FieldDict data;
  final BoardingPassTheme theme;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          data.label ?? '',
          style: theme.primaryLabelStyle,
        ),
        Text(
          data.formatted() ?? '',
          style: theme.primaryTextStyle,
        ),
      ],
    );
  }
}

class _AuxiliaryRow extends StatelessWidget {
  const _AuxiliaryRow({
    required this.auxiliaryRow,
    required this.theme,
  });

  final List<FieldDict> auxiliaryRow;
  final BoardingPassTheme theme;

  @override
  Widget build(BuildContext context) {
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
                  style: theme.auxiliaryLabelStyle,
                  textAlign: item.textAlignment.toFlutterTextAlign(),
                ),
                Text(
                  item.formatted() ?? '',
                  style: theme.auxiliaryTextStyle,
                  textAlign: item.textAlignment.toFlutterTextAlign(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
