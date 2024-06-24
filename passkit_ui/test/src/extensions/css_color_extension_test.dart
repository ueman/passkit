import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:csslib/parser.dart' as css;
import 'package:passkit_ui/passkit_ui.dart';

void main() {
  group('FlutterColor', () {
    group('toDartUiColor', () {
      test('should return a Color object', () {
        final cssColor = css.Color(0, 0);
        final result = cssColor.toDartUiColor();

        expect(result, isA<Color>());
      });

      test('should return a Color object with the correct ARGB values', () {
        final cssColor = css.Color(255, 0);
        final result = cssColor.toDartUiColor();

        expect(
          result,
          isSameColorAs(const Color.fromARGB(255, 0, 0, 255)),
        );
      });
    });
  });
}
