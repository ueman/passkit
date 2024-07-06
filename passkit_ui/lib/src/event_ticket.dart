import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/theme/theme.dart';

/// Event tickets
///
/// Use the event ticket style to give people entry into events like concerts,
/// movies, plays, and sporting events. Typically, each pass corresponds to a
/// specific event, but you can also use a single pass for several events,
/// as with a season ticket.
///
/// An event ticket can display logo, strip, background, or thumbnail images.
/// However, if you supply a strip image, don’t include a background or
/// thumbnail image. You can also include an extra row of up to four auxiliary
/// fields (for developer guidance, see the `row` property of
/// `PassFields.AuxiliaryFields`).
///
/// https://developer.apple.com/design/human-interface-guidelines/wallet#Event-tickets
class EventTicket extends StatelessWidget {
  const EventTicket({super.key, required this.pass});

  final PkPass pass;

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    final passTheme = pass.theme;
    final eventTicket = pass.pass.eventTicket!;

    assert(
      (pass.strip != null &&
              pass.background == null &&
              pass.thumbnail == null) ||
          pass.strip == null,
      "An event ticket can display logo, strip, background, or thumbnail images. However, if you supply a strip image, don't include a background or thumbnail image.",
    );

    return Card(
      color: passTheme.backgroundColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Stack(
        children: [
          if (pass.background != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: ClipRRect(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Image.memory(
                    fit: BoxFit.cover,
                    pass.background!.forCorrectPixelRatio(devicePixelRatio),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    /// The logo image (logo.png) is displayed in the top left corner
                    /// of the pass, next to the logo text. The allotted space is
                    /// 160 x 50 points; in most cases it should be narrower.
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 160,
                        maxHeight: 50,
                      ),
                      child: Image.memory(
                        pass.logo!.forCorrectPixelRatio(devicePixelRatio),
                        fit: BoxFit.contain,
                      ),
                    ),
                    if (pass.pass.logoText != null)
                      Text(
                        pass.pass.logoText!,
                        style: passTheme.foregroundTextStyle,
                      ),
                    const Spacer(),
                    // TODO(ueman): The header should be as wide as the thumbnail
                    Column(
                      children: [
                        Text(
                          eventTicket.headerFields?.first.label ?? '',
                          style: passTheme.labelTextStyle,
                        ),
                        Text(
                          eventTicket.headerFields?.first.value?.toString() ??
                              '',
                          style: passTheme.foregroundTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AuxiliaryRow(
                      passTheme: passTheme,
                      auxiliaryRow: eventTicket.primaryFields!,
                    ),
                    // The thumbnail image (`thumbnail.png`) displayed next to the
                    // fields on the front of the pass. The allotted space is
                    // 90 x 90 points. The aspect ratio should be in the range of
                    // 2:3 to 3:2, otherwise the image is cropped.
                    if (pass.thumbnail != null)
                      Image.memory(
                        pass.thumbnail!.forCorrectPixelRatio(devicePixelRatio),
                      ),
                  ],
                ),
                if (eventTicket.secondaryFields != null)
                  _AuxiliaryRow(
                    passTheme: passTheme,
                    auxiliaryRow: eventTicket.secondaryFields!,
                  ),
                if (eventTicket.auxiliaryFields != null) ...[
                  const SizedBox(height: 16),
                  _AuxiliaryRow(
                    passTheme: passTheme,
                    auxiliaryRow: eventTicket.auxiliaryFields!,
                  ),
                ],
                const SizedBox(height: 16),
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
                    passTheme: passTheme,
                  ),
              ],
            ),
          ),
        ],
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
  final PassTheme passTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: auxiliaryRow.map((item) {
        return Column(
          children: [
            Text(
              item.label ?? '',
              style: passTheme.labelTextStyle,
              textAlign: item.textAlignment?.toFlutterTextAlign(),
            ),
            Text(
              item.value.toString(),
              style: passTheme.foregroundTextStyle,
              textAlign: item.textAlignment?.toFlutterTextAlign(),
            ),
          ],
        );
      }).toList(),
    );
  }
}
