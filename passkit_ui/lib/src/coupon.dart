import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/extension/pk_pass_image_extensions.dart';
import 'package:passkit_ui/src/pass_theme.dart';
import 'package:passkit_ui/src/widgets/backfields_dialog.dart';

/// A coupon looks like the following:
///
/// ![](https://docs-assets.developer.apple.com/published/69bfb27a52f67ad10eb88d66276d0fa8/coupon@2x.png)
/// ![](https://docs-assets.developer.apple.com/published/e9ff886bf6d8e3f3202e165f5e0e5889/coupon-pass-layout@2x.png)
/// ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Art/coupon_2x.png)
///
/// For more information see
/// - https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1
/// - https://developer.apple.com/design/human-interface-guidelines/wallet
class Coupon extends StatelessWidget {
  const Coupon({super.key, required this.pass});

  final PkPass pass;

  @override
  Widget build(BuildContext context) {
    final passTheme = pass.toTheme();
    final coupon = pass.pass.coupon!;

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
                    pass.logo!.forCorrectPixelRatio(context),
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
                      coupon.headerFields?.first.label ?? '',
                      style: passTheme.labelTextStyle,
                    ),
                    Text(
                      coupon.headerFields?.first.value?.toString() ?? '',
                      style: passTheme.foregroundTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            _AuxiliaryRow(
              passTheme: passTheme,
              auxiliaryRow: coupon.primaryFields!,
            ),
            const SizedBox(height: 16),
            _AuxiliaryRow(
              passTheme: passTheme,
              auxiliaryRow: [
                ...?coupon.secondaryFields,
                ...?coupon.auxiliaryFields
              ],
            ),
            const SizedBox(height: 16),
            if (pass.footer != null)
              Image.memory(
                pass.footer!.forCorrectPixelRatio(context),
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
            if (coupon.backFields != null)
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () =>
                      showBackFieldsDialog(context, coupon.backFields!),
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
