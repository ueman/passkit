import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

void main() {
  group('PkTextAlignmentX', () {
    group('toFlutterTextAlign', () {
      final textAlignsLtr = {
        PkTextAlignment.left: TextAlign.left,
        PkTextAlignment.center: TextAlign.center,
        PkTextAlignment.right: TextAlign.right,
        PkTextAlignment.natural: TextAlign.left,
      };

      final textAlignsRtl = {
        PkTextAlignment.left: TextAlign.left,
        PkTextAlignment.center: TextAlign.center,
        PkTextAlignment.right: TextAlign.right,
        PkTextAlignment.natural: TextAlign.right,
      };

      test(
        'returns TextAlign.left when is default case',
        () => expect(
          PkTextAlignment.natural.toFlutterTextAlign(),
          equals(TextAlign.left),
        ),
      );

      test(
        'returns correct TextAlign for each PkTextAlignment '
        'when TextDirection is ltr',
        () {
          for (final textAlign in textAlignsLtr.entries) {
            final result = textAlign.key.toFlutterTextAlign(
              textDirection: TextDirection.ltr,
            );
            expect(result, equals(textAlign.value));
          }
        },
      );

      test(
        'returns correct TextAlign for each PkTextAlignment '
        'when TextDirection is rtl',
        () {
          for (final textAlign in textAlignsRtl.entries) {
            final result = textAlign.key.toFlutterTextAlign(
              textDirection: TextDirection.rtl,
            );
            expect(result, equals(textAlign.value));
          }
        },
      );
    });
  });
}
