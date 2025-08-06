import 'package:app/import_order/import_order_page.dart';
import 'package:app/import_pass/import_page.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

Future<void> pickPass(BuildContext context) async {
  final localizations = AppLocalizations.of(context);
  final result = await FilePicker.platform.pickFiles(
    dialogTitle: localizations.pickPasses,
    allowMultiple: false,
    type: FileType.any,
    //allowedExtensions: ['pkpass', 'pass'], // This seems to not work even when combined with "type: FileType.custom"
  );

  if (result == null) {
    return;
  }

  final firstPath = result.files.firstOrNull?.path;

  if (firstPath == null) {
    return;
  }

  if ({'.pkpass', '.pass'}.contains(extension(firstPath))) {
    await navigator.pushNamed(
      '/import',
      arguments: PkPassImportSource(filePath: firstPath),
    );
    return;
  }

  if ('.order' == extension(firstPath)) {
    await navigator.pushNamed(
      '/importOrder',
      arguments: PkOrderImportSource(filePath: firstPath),
    );
    return;
  }
}
