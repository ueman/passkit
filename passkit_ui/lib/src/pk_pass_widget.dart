import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/boarding_pass.dart';
import 'package:passkit_ui/src/coupon.dart';
import 'package:passkit_ui/src/event_ticket.dart';
import 'package:passkit_ui/src/generic.dart';
import 'package:passkit_ui/src/store_card.dart';

/// https://developer.apple.com/design/human-interface-guidelines/wallet
class PkPassWidget extends StatelessWidget {
  const PkPassWidget({
    super.key,
    required this.pass,
    required this.onPressed,
  });

  final PkPass pass;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    switch (pass.type) {
      case PassType.boardingPass:
        return BoardingPass(pass: pass);
      case PassType.coupon:
        return Coupon(pass: pass);
      case PassType.eventTicket:
        return EventTicket(pass: pass);
      case PassType.storeCard:
        return StoreCard(pass: pass);
      case PassType.unknown:
      case PassType.generic:
        return Generic(pass: pass);
    }
  }
}
