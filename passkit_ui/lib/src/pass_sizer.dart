import 'package:flutter/widgets.dart';

class PassSizer extends StatelessWidget {
  const PassSizer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 320,
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          height: 400,
          width: 320,
          child: child,
        ),
      ),
    );
  }
}
