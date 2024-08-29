import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:passkit/passkit.dart';
import 'package:test/test.dart';

void main() {
  test('roundtrip', () {
    final bytes = File('test/sample_passes/Coupon.pkpass').readAsBytesSync();
    final og = PkPass.fromBytes(
      bytes,
      skipChecksumVerification: true,
      skipSignatureVerification: true,
    );

    final createdPass = og.write()!;

    final copy = PkPass.fromBytes(
      Uint8List.fromList(createdPass),
      skipChecksumVerification: true,
      skipSignatureVerification: true,
    );

    // Make sure pass data is identical
    expect(
      jsonDecode(jsonEncode(og.pass.toJson())),
      jsonDecode(jsonEncode(copy.pass.toJson())),
    );

    // pass.json file is not identical due to whitespace differences
    final copyManifest = copy.manifest..remove('pass.json');
    final ogManifest = og.manifest..remove('pass.json');

    expect(copyManifest, ogManifest);
  });
}
