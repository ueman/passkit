import 'dart:io';

import 'package:app/db/db.dart';
import 'package:app/db/preferences.dart';
import 'package:app/import_pass/receive_pass.dart';
import 'package:app/main_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
  await initDb();
  await AppPreferences().init();
  runApp(const MainApp());
  if (!kIsWeb && Platform.isAndroid) {
    await initReceiveIntent();
    await initReceiveIntentWhileRunning();
  }
}
