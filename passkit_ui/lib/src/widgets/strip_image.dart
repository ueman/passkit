import 'package:flutter/widgets.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

/// The strip image (strip.png) is displayed behind the primary fields.
///
/// On iPhone 6 and 6 Plus The allotted space is 375 x 98 points for event
/// tickets, 375 x 144 points for gift cards and coupons, and 375 x 123 in all
/// other cases.
///
/// On prior hardware The allotted space is 320 x 84 points for event tickets,
/// 320 x 110 points for other pass styles with a square barcode on devices with
/// 3.5 inch screens, and 320 x 123 in all other cases.
class StripImage extends StatelessWidget {
  const StripImage({super.key, this.image, required this.type});

  final PkPassImage? image;
  final PassType type;

  @override
  Widget build(BuildContext context) {
    final size = switch (type) {
      PassType.boardingPass => const Size(320, 123),
      PassType.coupon => const Size(320, 144),
      PassType.eventTicket => const Size(320, 98),
      PassType.storeCard => const Size(320, 144),
      PassType.generic => const Size(320, 123),
      PassType.unknown => const Size(320, 123),
    };
    if (image == null) {
      return SizedBox(
        height: size.height,
        width: size.width,
      );
    }
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    return Image.memory(
      image!.forCorrectPixelRatio(devicePixelRatio),
      height: size.height,
      width: size.width,
      fit: BoxFit.cover,
    );
  }
}
