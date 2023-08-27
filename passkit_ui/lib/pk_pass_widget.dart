import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/boarding_pass.dart';
import 'package:passkit_ui/coupon.dart';
import 'package:passkit_ui/event_ticket.dart';
import 'package:passkit_ui/generic.dart';
import 'package:passkit_ui/store_card.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({
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
