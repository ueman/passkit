import 'dart:io';

import 'package:app/db/database.dart';
import 'package:app/db/preferences.dart';
import 'package:app/import_pass/receive_pass.dart';
import 'package:app/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
  initDb();
  await AppPreferences().init();
  runApp(const MainApp());
  if (Platform.isAndroid) {
    await initReceiveIntent();
    await initReceiveIntentWhileRunning();
  }
}
