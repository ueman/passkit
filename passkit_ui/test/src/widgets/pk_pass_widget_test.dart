import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

import '../../helpers/helpers.dart';

class _FakePkPass extends Fake implements PkPass {
  _FakePkPass({required this.type});

  @override
  final PassType type;

  @override
  PkPassImage? get icon => _passImage;

  @override
  PkPassImage? get logo => _passImage;

  @override
  PkPassImage? get footer => _passImage;

  @override
  PkPassImage? get strip => _passImage;

  @override
  PkPassImage? get background => null;

  @override
  PkPassImage? get thumbnail => null;

  @override
  PassData get pass {
    return PassData(
      description: 'description',
      formatVersion: 0,
      organizationName: 'organizationName',
      passTypeIdentifier: 'passTypeIdentifier',
      serialNumber: 'serialNumber',
      teamIdentifier: 'teamIdentifier',
      boardingPass: _passStructure,
      coupon: _passStructure,
      eventTicket: _passStructure,
      generic: _passStructure,
      storeCard: _passStructure,
      logoText: 'logoText',
    );
  }

  static final PkPassImage? _passImage = PkPassImage.fromImages(
    image1: transparentPixelPng,
    image2: transparentPixelPng,
    image3: transparentPixelPng,
  );

  static final PassStructure _passStructure = PassStructure(
    headerFields: [
      FieldDict(key: 'key', label: 'label', value: 'value'),
      FieldDict(key: 'key', label: 'label', value: 'value'),
    ],
    primaryFields: [
      FieldDict(key: 'key', label: 'label', value: 'value'),
      FieldDict(key: 'key', label: 'label', value: 'value'),
    ],
    secondaryFields: [
      FieldDict(key: 'key', label: 'label', value: 'value'),
      FieldDict(key: 'key', label: 'label', value: 'value'),
    ],
    auxiliaryFields: [
      FieldDict(key: 'key', label: 'label', value: 'value'),
      FieldDict(key: 'key', label: 'label', value: 'value'),
    ],
    backFields: [
      FieldDict(key: 'key', label: 'label', value: 'value'),
      FieldDict(key: 'key', label: 'label', value: 'value'),
    ],
  );
}

void main() {
  group('PkPassWidget', () {
    final passes = PassType.values.map((type) => _FakePkPass(type: type));

    final widgets = {
      PassType.boardingPass: BoardingPass(
        pass: passes.firstWhere((pass) => pass.type == PassType.boardingPass),
      ),
      PassType.coupon: Coupon(
        pass: passes.firstWhere((pass) => pass.type == PassType.coupon),
      ),
      PassType.eventTicket: EventTicket(
        pass: passes.firstWhere((pass) => pass.type == PassType.eventTicket),
      ),
      PassType.storeCard: StoreCard(
        pass: passes.firstWhere((pass) => pass.type == PassType.storeCard),
      ),
      PassType.generic: Generic(
        pass: passes.firstWhere((pass) => pass.type == PassType.generic),
      ),
      PassType.unknown: Generic(
        pass: passes.firstWhere((pass) => pass.type == PassType.unknown),
      ),
    };

    final zip = IterableZip([passes, widgets.entries]);

    for (final pair in zip) {
      final pass = pair.first as PkPass;
      final pkPassWidget = pair.last as MapEntry<PassType, Widget>;
      final passType = pass.type;
      final widgetType = pkPassWidget.value.runtimeType;

      testWidgets(
        'renders $widgetType when type is $passType',
        (tester) async {
          tester.view.devicePixelRatio = 1.0;

          await tester.pumpApp(PkPassWidget(pass: pass));
          expect(find.byType(widgetType), findsOneWidget);

          tester.view.resetDevicePixelRatio();
        },
      );
    }
  });
}
