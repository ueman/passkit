import 'package:app/db/preferences.dart';
import 'package:app/widgets/show_about_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings),
        actions: [
          IconButton(
            onPressed: () => showAboutWalletApp(context),
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            title:
                Text(AppLocalizations.of(context).overrideShareProhibitedFlag),
            value: AppPreferences().overrideShareProhibitedFlag,
            onChanged: (value) {
              if (value == AppPreferences().overrideShareProhibitedFlag) {
                return;
              }
              AppPreferences().overrideShareProhibitedFlag = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
