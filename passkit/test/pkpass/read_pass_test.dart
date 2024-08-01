import 'package:passkit/passkit.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  test('can read Event sample pass', () async {
    final bytes = loadSample(PassType.eventTicket);

    final pkPass = PkPass.fromBytes(
      bytes,
      skipChecksumVerification: true,
      skipSignatureVerification: true,
    );
    expect(pkPass.pass.serialNumber, 'nmyuxofgna');
  });

  test('can read Coupon sample pass', () async {
    final bytes = loadSample(PassType.coupon);

    final pkPass = PkPass.fromBytes(
      bytes,
      skipChecksumVerification: true,
      skipSignatureVerification: true,
    );
    expect(pkPass.pass.serialNumber, 'E5982H-I2');
  });

  test('can read StoreCard sample pass', () async {
    final bytes = loadSample(PassType.storeCard);

    final pkPass = PkPass.fromBytes(
      bytes,
      skipChecksumVerification: true,
      skipSignatureVerification: true,
    );
    expect(pkPass.pass.serialNumber, 'p69f2J');
  });

  test('can read Generic sample pass', () async {
    final bytes = loadSample(PassType.generic);

    final pkPass = PkPass.fromBytes(
      bytes,
      skipChecksumVerification: true,
      skipSignatureVerification: true,
    );
    expect(pkPass.pass.serialNumber, '8j23fm3');
  });
}
