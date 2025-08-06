import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context).appName.toUpperCase(),
      style: const TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 30,
      ),
    );
  }
}
