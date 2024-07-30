import 'dart:io';

import 'package:passkit/passkit.dart';
import 'package:passkit/src/pkpass/exceptions.dart';
import 'package:test/test.dart';

void main() {
  test('throws for checksum mismatch', () async {
    final bytes =
        File('test/sample_passes/generic_with_invalid_checksum.pkpass')
            .readAsBytesSync();

    expect(
      () => PkPass.fromBytes(bytes, skipSignatureVerification: true),
      throwsA(isA<ChecksumMismatchException>()),
    );
  });

  test('does not throw for invalid checksum when verification is skipped',
      () async {
    final bytes =
        File('test/sample_passes/generic_with_invalid_checksum.pkpass')
            .readAsBytesSync();

    expect(
      () => PkPass.fromBytes(
        bytes,
        skipChecksumVerification: true,
        skipSignatureVerification: true,
      ),
      returnsNormally,
    );
  });

  test('throws for missing checksum', () async {
    final bytes =
        File('test/sample_passes/generic_with_missing_checksum.pkpass')
            .readAsBytesSync();

    expect(
      () => PkPass.fromBytes(bytes, skipSignatureVerification: true),
      throwsA(isA<MissingChecksumException>()),
    );
  });

  test('does not throw for missing checksum when verification is skipped',
      () async {
    final bytes =
        File('test/sample_passes/generic_with_missing_checksum.pkpass')
            .readAsBytesSync();

    expect(
      () => PkPass.fromBytes(
        bytes,
        skipChecksumVerification: true,
        skipSignatureVerification: true,
      ),
      returnsNormally,
    );
  });

  test('does not throw for valid checksums', () async {
    final bytes =
        File('test/sample_passes/coffee_club.pkpass').readAsBytesSync();

    expect(
      () => PkPass.fromBytes(bytes, skipSignatureVerification: true),
      returnsNormally,
    );
  });

  test('does not throw for valid signature', () async {
    final bytes = File('test/sample_passes/cinema.pkpass').readAsBytesSync();

    expect(
      () => PkPass.fromBytes(bytes),
      returnsNormally,
    );
  });

  test('throws for invalid signature', () async {
    final bytes = File('test/sample_passes/Coupon.pkpass').readAsBytesSync();

    expect(
      () => PkPass.fromBytes(bytes),
      returnsNormally,
    );
  });
}
