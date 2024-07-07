import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/theme/boarding_pass_theme.dart';

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

    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        height: 400,
        width: 320,
        child: ColoredBox(
          color: theme.backgroundColor,
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
                      Text(
                        pass.pass.logoText!,
                        style: theme.logoTextStyle,
                      ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          boardingPass.headerFields!.first.label ?? '',
                          style: theme.headerLabelStyle,
                        ),
                        Text(
                          boardingPass.headerFields!.first.value.toString(),
                          style: theme.headerTextStyle,
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
                      theme: theme,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TransitTypeWidget(
                        transitType: boardingPass.transitType,
                        width: 40,
                        height: 40,
                        color: theme.foregroundColor,
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
                Footer(footer: pass.footer),
                const SizedBox(height: 2),
                if ((pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode) !=
                    null)
                  PasskitBarcode(
                    barcode:
                        (pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode)!,
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
          style: TextStyle(
            color: theme.labelColor,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          data.value.toString(),
          style: TextStyle(
            color: theme.foregroundColor,
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
                  item.value.toString(),
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
