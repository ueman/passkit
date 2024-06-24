import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

/// https://developer.apple.com/design/human-interface-guidelines/wallet
class PkPassWidget extends StatelessWidget {
  const PkPassWidget({
    super.key,
    required this.pass,
  });

  final PkPass pass;

  @override
  Widget build(BuildContext context) {
    return switch (pass.type) {
      PassType.boardingPass => BoardingPass(pass: pass),
      PassType.coupon => Coupon(pass: pass),
      PassType.eventTicket => EventTicket(pass: pass),
      PassType.storeCard => StoreCard(pass: pass),
      PassType.generic => Generic(pass: pass),
      PassType.unknown => Generic(pass: pass),
    };
  }
}
