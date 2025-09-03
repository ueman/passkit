import 'package:app/create_pass/create_pass_page.dart';
import 'package:app/db/preferences.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/widgets/app_version.dart';
import 'package:app/widgets/show_about_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
          ListTile(
            title: Text(AppLocalizations.of(context).reportIssue),
            leading: const Icon(Icons.bug_report),
            onTap: () {
              final bugReportUrl = Uri.parse(
                'https://github.com/ueman/passkit/issues/new?template=app_bug_report.yaml',
              );
              launchUrl(bugReportUrl);
            },
          ),
          ListTile(
            title: const Text('Create Pass'),
            leading: const Icon(Icons.add),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const CreatePassPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              MaterialLocalizations.of(context)
                  .aboutListTileTitle(AppLocalizations.of(context).appName),
            ),
            subtitle: const AppVersion(),
            leading: const Icon(Icons.info),
            onTap: () => showAboutWalletApp(context),
          ),
        ],
      ),
    );
  }
}
