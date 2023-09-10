import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

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
            onPressed: () => _openFile(context),
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

void _openFile(BuildContext context) async {
  final localizations = AppLocalizations.of(context);
  final result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    allowedExtensions: ['pkpass', 'pass'],
    dialogTitle: localizations.pickPasses,
    type: FileType.any,
  );

  if (result == null) {
    return;
  }

  if (!context.mounted) {
    return;
  }
  if (result.count == 1) {
    await context.push('/import', extra: result.files.first.path);
  }
}
