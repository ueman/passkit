import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:app/db/db.dart';
import 'package:app/db/pass_entry.dart';
import 'package:app/home/pass_list_notifier.dart';
import 'package:app/pass_backside/pass_backside_page.dart';
import 'package:app/router.dart';
import 'package:content_resolver/content_resolver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

class PkPassImportSource {
  PkPassImportSource({this.contentResolverPath, this.bytes, this.filePath})
      : assert(
          contentResolverPath != null || bytes != null || filePath != null,
        );

  final String? contentResolverPath;
  final String? filePath;
  final List<int>? bytes;

  Future<PkPass> getPass() async {
    if (contentResolverPath != null) {
      final Content content =
          await ContentResolver.resolveContent(contentResolverPath!);
      return PkPass.fromBytes(
        content.data,
        skipChecksumVerification: true,
        skipSignatureVerification: true,
      );
    } else if (bytes != null) {
      return PkPass.fromBytes(
        bytes!,
        skipChecksumVerification: true,
        skipSignatureVerification: true,
      );
    } else if (filePath != null) {
      return PkPass.fromBytes(
        await File(filePath!).readAsBytes(),
        skipChecksumVerification: true,
        skipSignatureVerification: true,
      );
    }
    throw Exception('No data');
  }
}

class ImportPassPage extends StatefulWidget {
  const ImportPassPage({super.key, required this.source});

  final PkPassImportSource source;

  @override
  State<ImportPassPage> createState() => _ImportPassPageState();
}

class _ImportPassPageState extends State<ImportPassPage> {
  PkPass? pass;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final pkPass = await widget.source.getPass();
    setState(() {
      pass = pkPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (pass == null) {
      child = const Center(child: CircularProgressIndicator());
    } else {
      child = Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              child: Center(child: PkPassWidget(pass: pass!)),
              onTap: () {
                router.push(
                  '/backside',
                  extra: PassBackSidePageArgs(pass!, false),
                );
              },
            ),
          ),
          // TODO(ueman): only offer this button if the pass isn't yet added
          ElevatedButton(
            onPressed: () async {
              await db.passEntryDao.insertPassEntry(
                PassEntry(
                  id: pass!.pass.serialNumber,
                  pass: Uint8List.fromList(pass!.sourceData),
                  description: pass!.pass.description,
                ),
              );
              if (context.mounted) {
                // If this page is opened via a file open intent, it can't be
                // popped via the navigator. Instead the button should be hidden.
                // When launched via the file selector, this page can be popped.
                final couldPop = await Navigator.maybePop(context);
                if (couldPop == false) {
                  // TODO(ueman): hide the import button
                }
              }
              unawaited(passListNotifier.loadPasses());
            },
            child: Text(AppLocalizations.of(context).importPass),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).import),
        actions: [
          IconButton(
            // TODO(ueman): Maybe show confirmation dialog here
            onPressed: () => context.pop(),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: child,
    );
  }
}
