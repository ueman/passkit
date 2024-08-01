import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/theme/boarding_pass_theme.dart';
import 'package:passkit_ui/src/widgets/header_row.dart';

/// A boarding pass looks like the following:
///
/// ![](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Art/boarding_pass_2x.png)
/// ![](https://www.apple.com/v/wallet/d/images/overview/boarding_pass__f5z923n6wtay_medium_2x.png)
///
/// It supports the following images:
/// - logo
/// - icon
/// - footer
///
/// For more information see
/// - https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1
/// - https://developer.apple.com/design/human-interface-guidelines/wallet
class BoardingPass extends StatelessWidget {
  const BoardingPass({super.key, required this.pass});

  final PkPass pass;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<BoardingPassTheme>()!;
    final boardingPass = pass.pass.boardingPass!;

    return ClipPath(
      clipper: _BoarderPassClipper(notchRadius: 13),
      child: ColoredBox(
        color: theme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderRow(
                passTheme: theme,
                logoText: pass.pass.logoText,
                headerFields: boardingPass.headerFields,
                logo: pass.logo,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _FromTo(
                    data: boardingPass.primaryFields!.first,
                    theme: theme,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TransitTypeWidget(
                      transitType: boardingPass.transitType,
                      width: 30,
                      height: 30,
                      color: theme.labelColor,
                    ),
                  ),
                  _FromTo(
                    data: boardingPass.primaryFields![1],
                    theme: theme,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (boardingPass.auxiliaryFields != null)
                _AuxiliaryRow(
                  auxiliaryRow: pass.pass.boardingPass!.auxiliaryFields!,
                  theme: theme,
                ),
              const SizedBox(height: 16),
              // secondary fields
              _AuxiliaryRow(
                auxiliaryRow: pass.pass.boardingPass!.secondaryFields!,
                theme: theme,
              ),

              const SizedBox(height: 16),
              if ((pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode) !=
                  null) ...[
                const Spacer(),
                Footer(footer: pass.footer),
                const SizedBox(height: 2),
                PasskitBarcode(
                  barcode:
                      (pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode)!,
                  fontSize: 12,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _FromTo extends StatelessWidget {
  const _FromTo({
    required this.data,
    required this.theme,
    required this.crossAxisAlignment,
  });

  final FieldDict data;
  final BoardingPassTheme theme;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          data.label ?? '',
          style: theme.primaryLabelStyle,
        ),
        Text(
          data.formatted() ?? '',
          style: theme.primaryTextStyle,
        ),
      ],
    );
  }
}

class _AuxiliaryRow extends StatelessWidget {
  const _AuxiliaryRow({
    required this.auxiliaryRow,
    required this.theme,
  });

  final List<FieldDict> auxiliaryRow;
  final BoardingPassTheme theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...auxiliaryRow.map(
          (item) => Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  item.label ?? '',
                  style: theme.auxiliaryLabelStyle,
                  textAlign: item.textAlignment.toFlutterTextAlign(),
                ),
                Text(
                  item.formatted() ?? '',
                  style: theme.auxiliaryTextStyle,
                  textAlign: item.textAlignment.toFlutterTextAlign(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BoarderPassClipper extends CustomClipper<Path> {
  _BoarderPassClipper({required this.notchRadius});

  final double notchRadius;
  final offsetFromTop = 108.0;
  static const roundedBoarder = ShapeBorderClipper(
    shape: ContinuousRectangleBorder(
      // TODO(any): put this into the theme
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  @override
  Path getClip(Size size) {
    final roundedBorderPath = roundedBoarder.getClip(size);

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0.0, offsetFromTop)
      ..arcToPoint(
        Offset(0, offsetFromTop + notchRadius),
        clockwise: true,
        radius: const Radius.circular(1),
      )
      //--
      ..lineTo(0.0, size.height) // bottom left corner
      ..lineTo(size.width, size.height) // bottom right corner
      //--
      ..lineTo(size.width, offsetFromTop + notchRadius)
      ..arcToPoint(
        Offset(size.width, offsetFromTop),
        clockwise: true,
        radius: const Radius.circular(1),
      )
      ..lineTo(size.width, 0) // top right corner
      ..lineTo(0, 0)
      ..close();

    return Path.combine(PathOperation.intersect, roundedBorderPath, path);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => oldClipper != this;
}
