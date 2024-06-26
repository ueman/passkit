import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passkit/passkit.dart';
import 'package:csslib/parser.dart' as css;
import 'package:passkit_ui/src/theme/theme.dart';

void main() {
  group('PassTheme', () {
    test('should return a PassTheme with the correct colors', () {
      const backgroundColor = Colors.red;
      const foregroundColor = Colors.green;
      const labelColor = Colors.blue;

      final theme = PassTheme(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        labelColor: labelColor,
      );

      expect(theme.backgroundColor, isSameColorAs(backgroundColor));
      expect(theme.foregroundColor, isSameColorAs(foregroundColor));
      expect(theme.labelColor, isSameColorAs(labelColor));
    });

    test('should return a PassTheme with the correct text styles', () {
      const backgroundColor = Colors.red;
      const foregroundColor = Colors.green;
      const labelColor = Colors.blue;

      final theme = PassTheme(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        labelColor: labelColor,
      );

      expect(theme.foregroundTextStyle.color, isSameColorAs(foregroundColor));
      expect(theme.backgroundTextStyle.color, isSameColorAs(backgroundColor));
      expect(theme.labelTextStyle.color, isSameColorAs(labelColor));
    });

    group('PkPassThemeX', () {
      test('returns correct colors for the given pass', () {
        final pass = PkPass(
          pass: PassData(
            description: 'description',
            formatVersion: 0,
            organizationName: 'organizationName',
            passTypeIdentifier: 'passTypeIdentifier',
            serialNumber: 'serialNumber',
            teamIdentifier: 'teamIdentifier',
            backgroundColor: css.Color.createRgba(255, 0, 0),
            foregroundColor: css.Color.createRgba(0, 255, 0),
            labelColor: css.Color.createRgba(0, 0, 255),
          ),
          manifest: {},
          sourceData: [],
        );

        final theme = pass.theme;

        expect(
          theme.backgroundColor,
          isSameColorAs(const Color.fromARGB(255, 255, 0, 0)),
        );
        expect(
          theme.foregroundColor,
          isSameColorAs(const Color.fromARGB(255, 0, 255, 0)),
        );
        expect(
          theme.labelColor,
          isSameColorAs(const Color.fromARGB(255, 0, 0, 255)),
        );
      });
    });
  });
}
