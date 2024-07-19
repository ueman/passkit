import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/theme/coupon_theme.dart';
import 'package:passkit_ui/src/widgets/header_row.dart';

/// A coupon looks like the following:
///
/// ![](https://docs-assets.developer.apple.com/published/69bfb27a52f67ad10eb88d66276d0fa8/coupon@2x.png)
/// ![](https://docs-assets.developer.apple.com/published/e9ff886bf6d8e3f3202e165f5e0e5889/coupon-pass-layout@2x.png)
/// ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Art/coupon_2x.png)
///
/// For more information see
/// - https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1
/// - https://developer.apple.com/design/human-interface-guidelines/wallet
class Coupon extends StatelessWidget {
  const Coupon({super.key, required this.pass});

  final PkPass pass;

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    final theme = Theme.of(context).extension<CouponTheme>()!;
    final coupon = pass.pass.coupon!;

    return ClipPath(
      clipBehavior: Clip.antiAlias,
      clipper: CouponClipper(
        Sides.vertical,
        heightOfPoint: 8,
        numberOfPoints: 40,
      ),
      child: ColoredBox(
        color: theme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderRow(
                passTheme: theme,
                headerFields: coupon.headerFields,
                logo: pass.logo,
                logoText: pass.pass.logoText,
              ),
              const SizedBox(height: 16),
              Stack(
                children: [
                  if (pass.strip != null)
                    Image.memory(
                      pass.strip!.forCorrectPixelRatio(devicePixelRatio),
                    ),
                  Column(
                    crossAxisAlignment: coupon
                            .primaryFields?.firstOrNull?.textAlignment
                            .toCrossAxisAlign() ??
                        CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        coupon.primaryFields?.firstOrNull?.formatted() ?? '',
                        style: theme.primaryTextStyle,
                        textAlign: coupon
                            .primaryFields?.firstOrNull?.textAlignment
                            .toFlutterTextAlign(),
                      ),
                      Text(
                        coupon.primaryFields?.firstOrNull?.label ?? '',
                        style: theme.primaryLabelStyle,
                        textAlign: coupon
                            .primaryFields?.firstOrNull?.textAlignment
                            .toFlutterTextAlign(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _AuxiliaryRow(
                passTheme: theme,
                auxiliaryRow: [
                  ...?coupon.secondaryFields,
                  ...?coupon.auxiliaryFields,
                ],
              ),
              const SizedBox(height: 16),
              const Spacer(),
              if (pass.footer != null)
                Image.memory(
                  pass.footer!.forCorrectPixelRatio(devicePixelRatio),
                  fit: BoxFit.contain,
                  width: 286,
                  height: 15,
                ),
              if ((pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode) !=
                  null)
                PasskitBarcode(
                  barcode:
                      (pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode)!,
                  fontSize: 11,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuxiliaryRow extends StatelessWidget {
  const _AuxiliaryRow({
    required this.auxiliaryRow,
    required this.passTheme,
  });

  final List<FieldDict> auxiliaryRow;
  final CouponTheme passTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: auxiliaryRow.map((item) {
        return Column(
          children: [
            Text(
              item.label ?? '',
              style: passTheme.auxiliaryLabelStyle,
              textAlign: item.textAlignment.toFlutterTextAlign(),
            ),
            Text(
              item.formatted() ?? '',
              style: passTheme.auxiliaryTextStyle,
              textAlign: item.textAlignment.toFlutterTextAlign(),
            ),
          ],
        );
      }).toList(),
    );
  }
}

enum Sides { bottom, vertical }

class CouponClipper extends CustomClipper<Path> {
  final double heightOfPoint;
  final int numberOfPoints;
  final Sides side;

  CouponClipper(
    this.side, {
    this.heightOfPoint = 12,
    this.numberOfPoints = 16,
  }); // final Sides side;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    double x = 0;
    double y = size.height;
    double yControlPoint = size.height - heightOfPoint;
    double increment = size.width / numberOfPoints;

    if (side == Sides.bottom || side == Sides.vertical) {
      while (x < size.width) {
        path.quadraticBezierTo(
            x + increment / 2, yControlPoint, x + increment, y);
        x += increment;
      }
    }

    path.lineTo(size.width, 0.0);

    if (side == Sides.vertical) {
      while (x > 0) {
        path.quadraticBezierTo(
            x - increment / 2, heightOfPoint, x - increment, 0);
        x -= increment;
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => oldClipper != this;
}
