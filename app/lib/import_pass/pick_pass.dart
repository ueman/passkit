import 'package:app/router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    // This is probably not a valid PkPass
    // TOOD show a hint to the user, that the user picked an ivalid file
    return;
  }

  await router.push('/import', extra: firstPath);
}
