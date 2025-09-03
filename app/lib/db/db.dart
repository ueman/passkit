import 'package:app/db/database.dart';
import 'package:flutter/foundation.dart';

late final AppDatabase db;

Future<void> initDb() async {
  if (kIsWeb) {
    return;
    // db = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
  } else {
    db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }
}
