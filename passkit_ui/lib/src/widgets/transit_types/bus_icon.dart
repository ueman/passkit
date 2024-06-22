import 'package:flutter/widgets.dart';

class BusIcon extends StatelessWidget {
  const BusIcon({super.key, required this.width, required this.color});

  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, (width * 1).toDouble()),
      painter: _RPSCustomPainter(color: color),
    );
  }
}

class _RPSCustomPainter extends CustomPainter {
  final Color color;

  _RPSCustomPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8103399, size.height * 0.2031164);
    path_0.cubicTo(
        size.width * 0.8010619,
        size.height * 0.1567150,
        size.width * 0.7713624,
        size.height * 0.1381545,
        size.width * 0.7268153,
        size.height * 0.1195917);
    path_0.cubicTo(
        size.width * 0.6828989,
        size.height * 0.1012936,
        size.width * 0.5776608,
        size.height * 0.07939931,
        size.width * 0.4999967,
        size.height * 0.07878636);
    path_0.cubicTo(
        size.width * 0.4223370,
        size.height * 0.07940151,
        size.width * 0.3171011,
        size.height * 0.1012936,
        size.width * 0.2731825,
        size.height * 0.1195917);
    path_0.cubicTo(
        size.width * 0.2286354,
        size.height * 0.1381523,
        size.width * 0.1989381,
        size.height * 0.1567128,
        size.width * 0.1896579,
        size.height * 0.2031164);
    path_0.lineTo(size.width * 0.1562498, size.height * 0.4603621);
    path_0.lineTo(size.width * 0.1562498, size.height * 0.8148290);
    path_0.lineTo(size.width * 0.2137879, size.height * 0.8148290);
    path_0.lineTo(size.width * 0.2137879, size.height * 0.8704158);
    path_0.cubicTo(
        size.width * 0.2137879,
        size.height * 0.9381911,
        size.width * 0.3129714,
        size.height * 0.9381911,
        size.width * 0.3129714,
        size.height * 0.8704158);
    path_0.lineTo(size.width * 0.3129714, size.height * 0.8148290);
    path_0.lineTo(size.width * 0.4960809, size.height * 0.8148290);
    path_0.lineTo(size.width * 0.4966607, size.height * 0.8148290);
    path_0.lineTo(size.width * 0.6870308, size.height * 0.8148290);
    path_0.lineTo(size.width * 0.6870308, size.height * 0.8704158);
    path_0.cubicTo(
        size.width * 0.6870308,
        size.height * 0.9381911,
        size.width * 0.7862121,
        size.height * 0.9381911,
        size.width * 0.7862121,
        size.height * 0.8704158);
    path_0.lineTo(size.width * 0.7862121, size.height * 0.8148290);
    path_0.lineTo(size.width * 0.8437502, size.height * 0.8148290);
    path_0.lineTo(size.width * 0.8437502, size.height * 0.4603621);
    path_0.lineTo(size.width * 0.8103399, size.height * 0.2031164);
    path_0.close();
    path_0.moveTo(size.width * 0.3585658, size.height * 0.1437218);
    path_0.lineTo(size.width * 0.4966585, size.height * 0.1437218);
    path_0.lineTo(size.width * 0.6414342, size.height * 0.1437218);
    path_0.cubicTo(
        size.width * 0.6692772,
        size.height * 0.1437218,
        size.width * 0.6692772,
        size.height * 0.1854841,
        size.width * 0.6414342,
        size.height * 0.1854841);
    path_0.lineTo(size.width * 0.4963212, size.height * 0.1854841);
    path_0.lineTo(size.width * 0.3585658, size.height * 0.1854841);
    path_0.cubicTo(
        size.width * 0.3307228,
        size.height * 0.1854841,
        size.width * 0.3307228,
        size.height * 0.1437218,
        size.width * 0.3585658,
        size.height * 0.1437218);
    path_0.close();
    path_0.moveTo(size.width * 0.2634193, size.height * 0.7037084);
    path_0.cubicTo(
        size.width * 0.2371418,
        size.height * 0.7037084,
        size.width * 0.2158384,
        size.height * 0.6824050,
        size.width * 0.2158384,
        size.height * 0.6561274);
    path_0.cubicTo(
        size.width * 0.2158384,
        size.height * 0.6298499,
        size.width * 0.2371418,
        size.height * 0.6085487,
        size.width * 0.2634193,
        size.height * 0.6085487);
    path_0.cubicTo(
        size.width * 0.2896969,
        size.height * 0.6085487,
        size.width * 0.3110003,
        size.height * 0.6298499,
        size.width * 0.3110003,
        size.height * 0.6561274);
    path_0.cubicTo(
        size.width * 0.3110003,
        size.height * 0.6824050,
        size.width * 0.2896969,
        size.height * 0.7037084,
        size.width * 0.2634193,
        size.height * 0.7037084);
    path_0.close();
    path_0.moveTo(size.width * 0.4966585, size.height * 0.4874731);
    path_0.lineTo(size.width * 0.2442922, size.height * 0.4874731);
    path_0.cubicTo(
        size.width * 0.2195845,
        size.height * 0.4874731,
        size.width * 0.2144119,
        size.height * 0.4697217,
        size.width * 0.2168372,
        size.height * 0.4518381);
    path_0.lineTo(size.width * 0.2428392, size.height * 0.2652604);
    path_0.cubicTo(
        size.width * 0.2464110,
        size.height * 0.2425922,
        size.width * 0.2540950,
        size.height * 0.2276477,
        size.width * 0.2835056,
        size.height * 0.2276477);
    path_0.lineTo(size.width * 0.4963212, size.height * 0.2276477);
    path_0.lineTo(size.width * 0.7164922, size.height * 0.2276477);
    path_0.cubicTo(
        size.width * 0.7459050,
        size.height * 0.2276477,
        size.width * 0.7535868,
        size.height * 0.2425922,
        size.width * 0.7571564,
        size.height * 0.2652604);
    path_0.lineTo(size.width * 0.7831628, size.height * 0.4518381);
    path_0.cubicTo(
        size.width * 0.7855881,
        size.height * 0.4697217,
        size.width * 0.7804155,
        size.height * 0.4874731,
        size.width * 0.7557078,
        size.height * 0.4874731);
    path_0.lineTo(size.width * 0.4966585, size.height * 0.4874731);
    path_0.close();
    path_0.moveTo(size.width * 0.7365785, size.height * 0.7037084);
    path_0.cubicTo(
        size.width * 0.7103009,
        size.height * 0.7037084,
        size.width * 0.6889997,
        size.height * 0.6824050,
        size.width * 0.6889997,
        size.height * 0.6561274);
    path_0.cubicTo(
        size.width * 0.6889997,
        size.height * 0.6298499,
        size.width * 0.7103009,
        size.height * 0.6085487,
        size.width * 0.7365785,
        size.height * 0.6085487);
    path_0.cubicTo(
        size.width * 0.7628560,
        size.height * 0.6085487,
        size.width * 0.7841572,
        size.height * 0.6298499,
        size.width * 0.7841572,
        size.height * 0.6561274);
    path_0.cubicTo(
        size.width * 0.7841572,
        size.height * 0.6824050,
        size.width * 0.7628560,
        size.height * 0.7037084,
        size.width * 0.7365785,
        size.height * 0.7037084);
    path_0.close();

    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = color;
    canvas.drawPath(path_0, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
