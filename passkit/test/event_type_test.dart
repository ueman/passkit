import 'package:passkit/passkit.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  test('can read Event sample pass', () async {
    final bytes = loadSample(PassType.eventTicket);

    final pkPass = PkPass.fromBytes(bytes);
    expect(pkPass.pass.serialNumber, 'nmyuxofgna');
  });

  test('has correct type', () async {
    final bytes = loadSample(PassType.eventTicket);

    final pkPass = PkPass.fromBytes(bytes);
    expect(pkPass.type, PassType.eventTicket);
  });

  test('has correct type property', () async {
    final bytes = loadSample(PassType.eventTicket);

    final pkPass = PkPass.fromBytes(bytes);
    expect(pkPass.pass.eventTicket, isNotNull);
  });

  test('has correct images', () async {
    final bytes = loadSample(PassType.eventTicket);

    final pkPass = PkPass.fromBytes(bytes);
    expect(pkPass.background, isNotNull);
    expect(pkPass.background?.image1, isNotNull);
    expect(pkPass.background?.image2, isNull);
    expect(pkPass.background?.image3, isNull);
    expect(pkPass.footer, isNull);
    expect(pkPass.icon, isNotNull);
    expect(pkPass.icon?.image1, isNotNull);
    expect(pkPass.icon?.image2, isNull);
    expect(pkPass.icon?.image3, isNull);
    expect(pkPass.logo, isNotNull);
    expect(pkPass.logo?.image1, isNotNull);
    expect(pkPass.logo?.image2, isNull);
    expect(pkPass.logo?.image3, isNull);
    expect(pkPass.personalizationLogo, isNull);
  });
}
