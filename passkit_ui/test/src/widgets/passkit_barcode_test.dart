import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passkit/passkit.dart' as pk;
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/theme/theme.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PasskitBarcode', () {
    testWidgets('renders correctly', (tester) async {
      const altText = '1234567890';

      await tester.pumpApp(
        PasskitBarcode(
          barcode: pk.Barcode(
            message: '1234567890',
            format: 'PKBarcodeFormatQR',
            messageEncoding: 'utf-8',
            altText: altText,
          ),
          passTheme: PassTheme(
            labelColor: Colors.green,
            foregroundColor: Colors.red,
            backgroundColor: Colors.blue,
          ),
        ),
      );

      expect(find.byType(BarcodeWidget), findsOneWidget);
      expect(find.text(altText), findsOneWidget);
    });
  });
}
