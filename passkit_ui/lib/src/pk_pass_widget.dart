import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/boarding_pass.dart';
import 'package:passkit_ui/src/coupon.dart';
import 'package:passkit_ui/src/event_ticket.dart';
import 'package:passkit_ui/src/generic.dart';
import 'package:passkit_ui/src/pass_sizer.dart';
import 'package:passkit_ui/src/store_card.dart';
import 'package:passkit_ui/src/theme/boarding_pass_theme.dart';
import 'package:passkit_ui/src/theme/coupon_theme.dart';
import 'package:passkit_ui/src/theme/store_card_theme.dart';

/// https://developer.apple.com/design/human-interface-guidelines/wallet
class PkPassWidget extends StatelessWidget {
  const PkPassWidget({
    super.key,
    required this.pass,
  });

  final PkPass pass;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeWithExtensions = theme.copyWith(
      extensions: [
        if (theme.extension<BoardingPassTheme>() == null)
          BoardingPassTheme.fromPass(pass),
        if (theme.extension<CouponTheme>() == null) CouponTheme.fromPass(pass),
        if (theme.extension<StoreCardTheme>() == null)
          StoreCardTheme.fromPass(pass),
      ],
    );

    return PassSizer(
      child: Theme(
        data: themeWithExtensions,
        child: switch (pass.type) {
          PassType.boardingPass => BoardingPass(pass: pass),
          PassType.coupon => Coupon(pass: pass),
          PassType.eventTicket => EventTicket(pass: pass),
          PassType.storeCard => StoreCard(pass: pass),
          PassType.generic => Generic(pass: pass),
          PassType.unknown => Generic(pass: pass),
        },
      ),
    );
  }
}
