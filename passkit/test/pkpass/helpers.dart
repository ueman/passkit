import 'dart:io';
import 'dart:typed_data';

import 'package:passkit/passkit.dart';

Uint8List loadSample(PassType type) {
  final fileName = switch (type) {
    PassType.boardingPass => 'BoardingPass_unsigned',
    PassType.coupon => 'Coupon',
    PassType.eventTicket => 'Event',
    PassType.storeCard => 'StoreCard',
    PassType.generic => 'Generic',
  };
  return File('test/sample_passes/$fileName.pkpass').readAsBytesSync();
}
