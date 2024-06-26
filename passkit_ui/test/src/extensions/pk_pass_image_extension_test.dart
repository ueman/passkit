import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

void main() {
  group('PkPassImageX', () {
    group('forCorrectPixelRatio', () {
      test('should return a Uint8List object', () {
        final uint8List = Uint8List.fromList([0, 2, 5, 7, 42, 255]);
        final passImage = PkPassImage.fromImages(
          image1: uint8List,
          image2: uint8List,
          image3: uint8List,
        );
        final result = passImage?.forCorrectPixelRatio(1.0);

        expect(result, isA<Uint8List>());
      });
    });
  });
}
