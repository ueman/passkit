import 'package:flutter/widgets.dart';

class PlaneIcon extends StatelessWidget {
  const PlaneIcon({super.key, required this.width, required this.color});

  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: CustomPaint(
        size: Size(width, (width * 1.006404833836858).toDouble()),
        painter: _RPSCustomPainter(color: color),
      ),
    );
  }
}

class _RPSCustomPainter extends CustomPainter {
  _RPSCustomPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9970354, size.height * 0.6100010);
    path_0.lineTo(size.width * 0.5601523, size.height * 0.2873877);
    path_0.cubicTo(
        size.width * 0.5633857,
        size.height * 0.2375484,
        size.width * 0.5654886,
        size.height * 0.1262595,
        size.width * 0.5635951,
        size.height * 0.1056010);
    path_0.cubicTo(
        size.width * 0.5477227,
        size.height * -0.06757571,
        size.width * 0.4377938,
        size.height * 0.007017402,
        size.width * 0.4367740,
        size.height * 0.08430588);
    path_0.cubicTo(
        size.width * 0.4364948,
        size.height * 0.1054448,
        size.width * 0.4326853,
        size.height * 0.2147829,
        size.width * 0.4323240,
        size.height * 0.2877826);
    path_0.lineTo(size.width * 0.001145103, size.height * 0.6178979);
    path_0.lineTo(0, size.height * 0.7212446);
    path_0.lineTo(size.width * 0.4451181, size.height * 0.5191857);
    path_0.lineTo(size.width * 0.4612040, size.height * 0.8405579);
    path_0.lineTo(size.width * 0.3321302, size.height * 0.9323693);
    path_0.lineTo(size.width * 0.3313091, size.height * 1.000000);
    path_0.lineTo(size.width * 0.5015882, size.height * 0.9535880);
    path_0.lineTo(size.width * 0.5016204, size.height * 0.9541463);
    path_0.lineTo(size.width * 0.6736772, size.height * 0.9978495);
    path_0.lineTo(size.width * 0.6716257, size.height * 0.9302777);
    path_0.lineTo(size.width * 0.5408956, size.height * 0.8406242);
    path_0.lineTo(size.width * 0.5514145, size.height * 0.5190102);
    path_0.lineTo(size.width * 0.9999944, size.height * 0.7131589);
    path_0.lineTo(size.width * 0.9970339, size.height * 0.6100010);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
