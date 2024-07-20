import 'dart:io';

import 'package:test/test.dart';

void main() {
  test('foo', () {
    final bytes = File('test/AppleWWDRMPCA1G1.cer').readAsBytesSync();
    print(bytes);
  });
}
