import 'package:app/widgets/app_icon.dart';
import 'package:app/widgets/app_version.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showAboutWalletApp(BuildContext context) {
  return showAboutDialog(
    context: context,
    applicationIcon: const AppIcon(),
    applicationName: '',
    children: [
      Text(AppLocalizations.of(context).appDescription),
      const SizedBox(height: 8),
      const AppVersion(),
    ],
  );
}
