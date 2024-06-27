import 'package:flutter/widgets.dart';
import 'package:passkit_ui/src/theme/pass_theme.dart';

class PassSize extends StatelessWidget {
  const PassSize({super.key, required this.child, required this.theme});

  final Widget child;
  final PassTheme theme;

  @override
  Widget build(BuildContext context) {
    // TODO(ueman): Improve sizing mechanism, since it's not a11y friendly.
    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        height: theme.height,
        width: theme.width,
        child: child,
      ),
    );
  }
}
