import 'package:app/import_pass/pick_pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).appName.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => pickPass(context),
            icon: const Icon(Icons.file_open),
          ),
          IconButton(
            onPressed: () => showAboutDialog(
              context: context,
              applicationName:
                  AppLocalizations.of(context).appName.toUpperCase(),
            ),
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: const Center(child: Text('Cards')),
    );
  }
}
