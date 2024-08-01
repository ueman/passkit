import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Footer', () {
    testWidgets('renders nothing when PkPassImage is null', (tester) async {
      await tester.pumpApp(const Footer(footer: null));
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets(
      'renders an Image when PkPassImage is not null',
      (tester) async {
        tester.view.display.devicePixelRatio = 1.0;

        final footer = PkImage.fromImages(
          image1: transparentPixelPng,
          image2: transparentPixelPng,
          image3: transparentPixelPng,
        );
        await tester.pumpApp(Footer(footer: footer));
        expect(find.byType(Image), findsOneWidget);

        tester.view.display.resetDevicePixelRatio();
      },
    );
  });
}
