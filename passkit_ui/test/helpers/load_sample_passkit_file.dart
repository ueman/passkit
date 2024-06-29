import 'dart:io';

import 'package:passkit/passkit.dart';

PkPass loadSample(PassType type) {
  final fileName = switch (type) {
    PassType.boardingPass => 'BoardingPass_unsigned',
    PassType.coupon => 'Coupon',
    PassType.eventTicket => 'Event',
    PassType.storeCard => 'StoreCard',
    PassType.generic => 'Generic',
    PassType.unknown => 'Generic',
  };
  final bytes = File('test/sample_passes/$fileName.pkpass').readAsBytesSync();
  return PkPass.fromBytes(bytes);
}
