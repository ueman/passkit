import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:passkit_ui/src/theme/event_ticket_theme.dart';
import 'package:passkit_ui/src/widgets/header_row.dart';
import 'package:passkit_ui/src/widgets/strip_image.dart';
import 'package:passkit_ui/src/widgets/thumbnail.dart';

/// Event ticket
///
/// Use the event ticket style to give people entry into events like concerts,
/// movies, plays, and sporting events. Typically, each pass corresponds to a
/// specific event, but you can also use a single pass for several events,
/// as with a season ticket.
///
/// An event ticket can display logo, strip, background, or thumbnail images.
/// However, if you supply a strip image, don’t include a background or
/// thumbnail image. You can also include an extra row of up to four auxiliary
/// fields (for developer guidance, see the `row` property of [FieldDict.row]).
///
/// https://developer.apple.com/design/human-interface-guidelines/wallet#Event-tickets
class EventTicket extends StatelessWidget {
  const EventTicket({super.key, required this.pass});

  final PkPass pass;

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    final passTheme = Theme.of(context).extension<EventTicketTheme>()!;
    final eventTicket = pass.pass.eventTicket!;

    assert(
      (pass.strip != null &&
              pass.background == null &&
              pass.thumbnail == null) ||
          pass.strip == null,
      "An event ticket can display logo, strip, background, or thumbnail images. However, if you supply a strip image, don't include a background or thumbnail image.",
    );

    return ClipPath(
      // TODO(any): should be part of the theme
      clipper: _TicketPassClipper(notchRadius: 50),
      child: ColoredBox(
        color: passTheme.backgroundColor,
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
                  HeaderRow(
                    passTheme: passTheme,
                    headerFields: eventTicket.headerFields,
                    logo: pass.logo,
                    logoText: pass.pass.logoText,
                  ),
                  const SizedBox(height: 16),
                  if (pass.strip != null)
                    _StripRow(
                      pass: pass,
                      theme: passTheme,
                    ),
                  // An event ticket without a strip doesn't necessarily need to
                  // have a thumbnail, that's why we check for the absence of
                  // the strip image instead of the presence of the thumbnail
                  // image.
                  if (pass.strip == null)
                    _ThumbnailRow(pass: pass, passTheme: passTheme),
                  const Spacer(),
                  if ((pass.pass.barcodes?.firstOrNull ?? pass.pass.barcode) !=
                      null)
                    PasskitBarcode(
                      barcode: (pass.pass.barcodes?.firstOrNull ??
                          pass.pass.barcode)!,
                      fontSize: 11,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThumbnailRow extends StatelessWidget {
  const _ThumbnailRow({required this.pass, required this.passTheme});

  final PkPass pass;
  final EventTicketTheme passTheme;

  @override
  Widget build(BuildContext context) {
    final eventTicket = pass.pass.eventTicket!;

    final auxiliaryRowZero = eventTicket.auxiliaryFields
        ?.where((row) => row.row == null || row.row == 0)
        .toList();
    final auxiliaryRowOne =
        eventTicket.auxiliaryFields?.where((row) => row.row == 1).toList();

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (eventTicket.primaryFields != null)
                    _FieldRow(
                      passTheme: passTheme,
                      auxiliaryRow: eventTicket.primaryFields!,
                      isPrimary: true,
                    ),
                  const SizedBox(height: 8),
                  if (eventTicket.secondaryFields != null)
                    _FieldRow(
                      passTheme: passTheme,
                      auxiliaryRow: eventTicket.secondaryFields!,
                    ),
                ],
              ),
            ),
            Thumbnail(thumbnail: pass.thumbnail),
          ],
        ),
        if (auxiliaryRowZero != null && auxiliaryRowZero.isNotEmpty) ...[
          const SizedBox(height: 16),
          _FieldRow(
            passTheme: passTheme,
            auxiliaryRow: auxiliaryRowZero,
          ),
          if (auxiliaryRowOne != null && auxiliaryRowOne.isNotEmpty) ...[
            const SizedBox(height: 16),
            _FieldRow(
              passTheme: passTheme,
              auxiliaryRow: auxiliaryRowOne,
            ),
          ],
        ],
      ],
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({
    required this.auxiliaryRow,
    required this.passTheme,
    this.isPrimary = false,
  });

  final List<FieldDict> auxiliaryRow;
  final EventTicketTheme passTheme;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: auxiliaryRow.map((item) {
        // TODO(any): Use IntrinsicWidth instead, which looks more like the
        // UI in Apple Wallet.
        // TODO(any): Properly handle text overflow
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                item.label ?? '',
                style: isPrimary
                    ? passTheme.primaryWithThumbnailLabelStyle
                    : passTheme.secondaryWithThumbnailLabelStyle,
                textAlign: item.textAlignment.toFlutterTextAlign(),
              ),
              Text(
                item.formatted() ?? '',
                style: isPrimary
                    ? passTheme.primaryWithThumbnailTextStyle
                    : passTheme.secondaryWithThumbnailTextStyle,
                textAlign: item.textAlignment.toFlutterTextAlign(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _StripRow extends StatelessWidget {
  const _StripRow({
    required this.pass,
    required this.theme,
  });

  final PkPass pass;
  final EventTicketTheme theme;

  @override
  Widget build(BuildContext context) {
    final eventTicket = pass.pass.eventTicket!;

    const padding = 16.0;
    //const verticalPadding = EdgeInsets.symmetric(vertical: padding);
    const horizontalPadding = EdgeInsets.symmetric(horizontal: padding);

    return Stack(
      children: [
        if (pass.strip != null)
          StripImage(image: pass.strip, type: PassType.storeCard),
        Padding(
          padding: horizontalPadding.copyWith(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                eventTicket.primaryFields?.firstOrNull?.formatted() ?? '',
                style: theme.primaryWithStripLabelStyle,
                textAlign: eventTicket.primaryFields?.firstOrNull?.textAlignment
                    .toFlutterTextAlign(),
              ),
              Text(
                eventTicket.primaryFields?.firstOrNull?.label ?? '',
                style: theme.primaryWithStripTextStyle,
                textAlign: eventTicket.primaryFields?.firstOrNull?.textAlignment
                    .toFlutterTextAlign(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TicketPassClipper extends CustomClipper<Path> {
  _TicketPassClipper({required this.notchRadius});

  final double notchRadius;

  @override
  Path getClip(Size size) {
    final position = (size.width / 2) + (notchRadius / 2);
    if (position > size.width) {
      throw Exception('position is greater than width.');
    }
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(position - notchRadius, 0.0)
      ..arcToPoint(
        Offset(position, 0),
        clockwise: false,
        radius: const Radius.circular(1),
      )
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height);

    path.lineTo(0.0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => oldClipper != this;
}
