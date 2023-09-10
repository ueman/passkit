import 'dart:typed_data';

import 'package:app/db/database.dart';
import 'package:app/db/db.dart';
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
            child: PkPassWidget(pass: pass!, onPressed: () {}),
          ),
          ElevatedButton(
            onPressed: () async {
              await database.into(database.pass).insert(
                    PassCompanion.insert(
                      id: pass!.pass.serialNumber,
                      binaryPass: Uint8List.fromList(pass!.sourceData),
                    ),
                  );
            },
            child: Text(
              AppLocalizations.of(context).importPass,
            ),
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).import),
        actions: [
          IconButton(
            // TODO Maybe show confirmation dialog here
            onPressed: () => context.pop(),
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: child,
    );
  }
}
