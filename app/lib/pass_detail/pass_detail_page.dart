import 'dart:io';

import 'package:app/pass_backside/pass_backside_page.dart';
import 'package:app/widgets/keep_alive.dart';
import 'package:app/widgets/squircle.dart';
import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PassDetailPage extends StatefulWidget {
  const PassDetailPage({
    super.key,
    required this.pass,
    this.showDelete = false,
  });

  final ReadOnlyPkPass pass;
  final bool showDelete;

  @override
  State<PassDetailPage> createState() => _PassDetailPageState();
}

class _PassDetailPageState extends State<PassDetailPage> {
  @override
  Widget build(BuildContext context) {
    final sharingAllowed = !(widget.pass.pass.sharingProhibited ?? false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            spacing: 8,
            children: [
              if (widget.pass.icon != null)
                Squircle(
                  radius: 10,
                  child: Image.memory(
                    widget.pass.icon!.fromMultiplier(3),
                    fit: BoxFit.contain,
                    height: kToolbarHeight *
                        (2 / 3), // unscientific calculation, but looks good
                  ),
                ),
              if (widget.pass.pass.description.isNotEmpty)
                Expanded(
                  child: Text(
                    widget.pass.pass.description,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
          actions: [
            if (sharingAllowed)
              IconButton(
                icon: Icon(Icons.adaptive.share),
                onPressed: _sharePass,
              ),
            IconButton(
              icon: const Icon(Icons.image),
              onPressed: _sharePassAsImage,
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Front'),
              Tab(text: 'Back'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            KeepAliveAndBright(
              child: Center(
                child: Hero(
                  tag: widget.pass.pass.serialNumber,
                  child: PkPassWidget(pass: widget.pass),
                ),
              ),
            ),
            PassBacksidePage(
              pass: widget.pass,
              showDelete: widget.showDelete,
            ),
          ],
        ),
      ),
    );
  }

  void _sharePass() {
    final data = widget.pass.sourceData!;
    SharePlus.instance.share(
      ShareParams(files: [XFile.fromData(data)]),
    );
  }

  void _sharePassAsImage() async {
    final name = widget.pass.pass.serialNumber;
    final imageData = await exportPassAsImage(widget.pass);
    if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      final dir = await getApplicationDocumentsDirectory();

      await File(p.join(dir.path, '$name.png')).writeAsBytes(imageData!);
    } else {
      if (imageData != null) {
        await SharePlus.instance.share(
          ShareParams(
            files: [
              XFile.fromData(
                imageData,
                name: 'pass.png',
                mimeType: 'image/png',
              ),
            ],
          ),
        );
      }
    }
  }
}
