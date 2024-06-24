import 'dart:typed_data';

import 'package:app/db/database.dart';
import 'package:app/db/db.dart';
import 'package:app/pass_backside/pass_backside_page.dart';
import 'package:app/router.dart';
import 'package:content_resolver/content_resolver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

class ImportPassPage extends StatefulWidget {
  const ImportPassPage({super.key, required this.path});

  final String path;

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
    final Content content = await ContentResolver.resolveContent(widget.path);
    final pkPass = PkPass.fromBytes(content.data);
    setState(() {
      pass = pkPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (pass == null) {
      child = Center(child: Text(widget.path));
    } else {
      child = Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              child: PkPassWidget(pass: pass!),
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
              await database.into(database.pass).insert(
                    PassCompanion.insert(
                      id: pass!.pass.serialNumber,
                      binaryPass: Uint8List.fromList(pass!.sourceData),
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
