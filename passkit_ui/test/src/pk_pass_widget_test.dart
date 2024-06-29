import 'package:flutter_test/flutter_test.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/boarding_pass.dart';
import 'package:passkit_ui/src/coupon.dart';
import 'package:passkit_ui/src/event_ticket.dart';
import 'package:passkit_ui/src/generic.dart';

import '../helpers/helpers.dart';
import '../helpers/load_sample_passkit_file.dart';

void main() {
  group('PkPassWidget', () {
    testWidgets(
      'renders BoardingPass when type is PassType.boardingPass',
      (tester) async {
        await tester
            .pumpApp(PkPassWidget(pass: loadSample(PassType.boardingPass)));
        expect(find.byType(BoardingPass), findsOneWidget);
      },
    );

    testWidgets(
      'renders Coupon when type is PassType.coupon',
      (tester) async {
        await tester.pumpApp(PkPassWidget(pass: loadSample(PassType.coupon)));
        expect(find.byType(Coupon), findsOneWidget);
      },
    );

    testWidgets(
      'renders EventTicket when type is PassType.eventTicket',
      (tester) async {
        await tester
            .pumpApp(PkPassWidget(pass: loadSample(PassType.eventTicket)));
        expect(find.byType(EventTicket), findsOneWidget);
      },
    );

    testWidgets(
      'renders Generic when type is PassType.generic',
      (tester) async {
        await tester.pumpApp(PkPassWidget(pass: loadSample(PassType.generic)));
        expect(find.byType(Generic), findsOneWidget);
      },
    );

    testWidgets(
      'renders Generic when type is PassType.unknown',
      (tester) async {
        await tester.pumpApp(PkPassWidget(pass: loadSample(PassType.unknown)));
        expect(find.byType(Generic), findsOneWidget);
      },
    );
  });
}
