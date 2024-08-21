import 'package:app/db/database.dart';

late final AppDatabase db;

Future<void> initDb() async {
  db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
}
