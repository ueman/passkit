import 'package:app/db/database.dart';
import 'package:app/import_pass/import_page.dart';
import 'package:app/import_pass/pick_pass.dart';
import 'package:app/pass_backside/pass_backside_page.dart';
import 'package:app/router.dart';
import 'package:app/widgets/app_icon.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PkPass> passes = [];

  @override
  void initState() {
    super.initState();
    loadPasses();
  }

  Future<void> loadPasses() async {
    final dbPasses = await database.pass.select(distinct: true).get();
    final mappedPasses = dbPasses.map((p) {
      return PkPass.fromBytes(p.binaryPass);
    }).toList();
    setState(() {
      passes = mappedPasses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (detail) async {
        final firstFile = detail.files.firstOrNull;

        if (firstFile == null) {
          return;
        }
        // TODO(ueman): Add more validation

        await router.push(
          '/import',
          extra: PkPassImportSource(
            bytes: await detail.files.first.readAsBytes(),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const AppIcon(),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => pickPass(context),
              icon: const Icon(Icons.file_open),
            ),
            IconButton(
              onPressed: () => router.push('/settings'),
              icon: const Icon(Icons.settings),
              tooltip: AppLocalizations.of(context).settings,
            ),
          ],
        ),
        body: passes.isEmpty
            ? const Center(child: Text('No passes'))
            : RefreshIndicator(
                onRefresh: () => loadPasses(),
                child: ListView.builder(
                  itemCount: passes.length,
                  itemBuilder: (context, index) {
                    final pass = passes[index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        child: PkPassWidget(pass: pass),
                        onTap: () {
                          router.push(
                            '/backside',
                            extra: PassBackSidePageArgs(pass, true),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
