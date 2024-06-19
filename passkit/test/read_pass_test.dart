import 'dart:io';

import 'package:passkit/passkit.dart';
import 'package:test/test.dart';

void main() {
  test('can read Event sample pass', () async {
    final bytes = await File('test/sample_passes/Event.pkpass').readAsBytes();

    final pkPass = PkPass.fromBytes(bytes);
    expect(pkPass.pass.serialNumber, 'nmyuxofgna');
  });
}
