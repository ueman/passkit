import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/theme/store_card_theme.dart';
import 'package:passkit_ui/src/widgets/header_row.dart';

/// A store card looks like the following:
///
/// ![](https://docs-assets.developer.apple.com/published/f81fefc86a3b46a8052c2164131d2583/store-card@2x.png)
/// ![](https://docs-assets.developer.apple.com/published/7b648e914e0e99562fcf512efb115175/store-card-layout@2x.png)
/// ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Art/store_card_2x.png)
///
/// For more information see
/// - https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1
/// - https://developer.apple.com/design/human-interface-guidelines/wallet

class StoreCard extends StatelessWidget {
  const StoreCard({super.key, required this.pass});

  final PkPass pass;

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    final theme = Theme.of(context).extension<StoreCardTheme>()!;
    final storeCard = pass.pass.storeCard!;

    return ClipPath(
      clipper: const ShapeBorderClipper(
        shape: ContinuousRectangleBorder(
          // TODO(any): put this into the theme
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      child: ColoredBox(
        color: theme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderRow(
                passTheme: theme,
                headerFields: storeCard.headerFields,
                logo: pass.logo,
                logoText: pass.pass.logoText,
              ),
              const SizedBox(height: 16),
              Stack(
                children: [
                  if (pass.strip != null)
                    Image.memory(
                      pass.strip!.forCorrectPixelRatio(devicePixelRatio),
                    ),
                  Column(
                    crossAxisAlignment: storeCard
                            .primaryFields?.firstOrNull?.textAlignment
                            .toCrossAxisAlign() ??
                        CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        storeCard.primaryFields?.firstOrNull?.formatted() ?? '',
                        style: theme.primaryTextStyle,
                        textAlign: storeCard
                            .primaryFields?.firstOrNull?.textAlignment
                            .toFlutterTextAlign(),
                      ),
                      Text(
                        storeCard.primaryFields?.firstOrNull?.label ?? '',
                        style: theme.primaryLabelStyle,
                        textAlign: storeCard
                            .primaryFields?.firstOrNull?.textAlignment
                            .toFlutterTextAlign(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _AuxiliaryRow(
                passTheme: theme,
                auxiliaryRow: [
                  ...?storeCard.secondaryFields,
                  ...?storeCard.auxiliaryFields,
                ],
              ),
              const SizedBox(height: 16),
              const Spacer(),
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
  final StoreCardTheme passTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: auxiliaryRow.map((item) {
        return Column(
          children: [
            Text(
              item.label ?? '',
              style: passTheme.auxiliaryLabelStyle,
              textAlign: item.textAlignment.toFlutterTextAlign(),
            ),
            Text(
              item.formatted() ?? '',
              style: passTheme.auxiliaryTextStyle,
              textAlign: item.textAlignment.toFlutterTextAlign(),
            ),
          ],
        );
      }).toList(),
    );
  }
}
