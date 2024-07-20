import 'package:flutter/widgets.dart';

class PassSizer extends StatelessWidget {
  const PassSizer({super.key, required this.child});

  final Widget child;

  static const width = 320.0;
  static const height = 460.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          height: height,
          width: width,
          child: child,
        ),
      ),
    );
  }
}
