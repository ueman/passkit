import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart' as passkit;
import 'package:passkit_ui/src/theme/theme.dart';

/// PassKit displays the first supported barcode in this array.
/// Note that the `PKBarcodeFormatQR`, `PKBarcodeFormatPDF417`,
/// `PKBarcodeFormatAztec`, and `PKBarcodeFormatCode128` formats are all valid
/// on iOS 9 and later; therefore, they do not need fallbacks.
class PasskitBarcode extends StatelessWidget {
  const PasskitBarcode({
    super.key,
    required this.barcode,
    required this.passTheme,
  });

  final passkit.Barcode barcode;
  final PassTheme passTheme;

  @override
  Widget build(BuildContext context) {
    double? height;
    double? width;
    if ({
      'PKBarcodeFormatQR', /* 'PKBarcodeFormatAztec' */
    }.contains(barcode.format)) {
      // These two formats are quadratic, meaning they have the same height and width.
      height = 150;
      width = 150;
    } else {
      // The other codes are much wider than tall.
      // Not too sure which dimension they should have, though.
      // Apples designs make it seem they should be as wide as possible.
      height = 80;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BarcodeWidget(
              height: height,
              width: width,
              data: barcode.message,
              barcode: barcode.formatType,
              drawText: false,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              backgroundColor: Colors.white,
              color: Colors.black,
              textPadding: 0,
            ),
            if (barcode.altText != null)
              Text(
                barcode.altText!,
                style: passTheme.foregroundTextStyle.copyWith(
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
