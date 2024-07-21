import 'package:app/db/database.dart';
import 'package:app/import_order/import_order_page.dart';
import 'package:app/import_pass/import_page.dart';
import 'package:app/import_pass/pick_pass.dart';
import 'package:app/pass_backside/pass_backside_page.dart';
import 'package:app/router.dart';
import 'package:app/widgets/app_icon.dart';
import 'package:app/widgets/pass_list_tile.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/foundation.dart';
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

  PassView passView = PassView.preview;

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

        if (firstFile.name.endsWith('pkpass')) {
          await router.push(
            '/import',
            extra: PkPassImportSource(
              bytes: await detail.files.first.readAsBytes(),
            ),
          );
        }
        if (firstFile.name.endsWith('order')) {
          await router.push(
            '/importOrder',
            extra: PkOrderImportSource(
              bytes: await detail.files.first.readAsBytes(),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const AppIcon(),
          centerTitle: true,
          leading: kDebugMode
              ? IconButton(
                  onPressed: () => router.push('/examples'),
                  icon: const Icon(Icons.card_giftcard),
                )
              : null,
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
        body: Column(
          children: [
            ViewChooser(
              selected: passView,
              onViewChanged: (newViewSelection) {
                setState(() {
                  passView = newViewSelection;
                });
              },
            ),
            passes.isEmpty
                ? const Center(child: Text('No passes'))
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => loadPasses(),
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                        itemCount: passes.length,
                        itemBuilder: (context, index) {
                          final pass = passes[index];
                          if (passView == PassView.compact) {
                            return PassListTile(
                              pass: pass,
                              onTap: () {
                                router.push(
                                  '/backside',
                                  extra: PassBackSidePageArgs(pass, true),
                                );
                              },
                            );
                          } else {
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
                          }
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class ViewChooser extends StatelessWidget {
  const ViewChooser({
    super.key,
    required this.onViewChanged,
    required this.selected,
  });

  final ValueChanged<PassView> onViewChanged;
  final PassView selected;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<PassView>(
      segments: const <ButtonSegment<PassView>>[
        ButtonSegment<PassView>(
          value: PassView.preview,
          label: Text('Preview'),
          icon: Icon(Icons.preview),
        ),
        ButtonSegment<PassView>(
          value: PassView.compact,
          label: Text('Compact'),
        ),
        /*
        ButtonSegment<PassView>(
          value: PassView.calendar,
          label: Text('Calendar'),
          icon: Icon(Icons.calendar_month),
        ),
        */
      ],
      selected: {selected},
      onSelectionChanged: (selection) => onViewChanged(selection.first),
      multiSelectionEnabled: false,
    );
  }
}

enum PassView {
  /// Shows a calendar
  calendar,

  /// Shows a preview of the actual pass
  preview,

  /// Shows list tiles with a brief description
  compact,
}
