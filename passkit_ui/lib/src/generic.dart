import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';

/// https://developer.apple.com/design/human-interface-guidelines/wallet#Generic-passes
class Generic extends StatelessWidget {
  const Generic({super.key, required this.pass});

  final PkPass pass;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
