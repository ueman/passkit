import 'dart:async';
import 'dart:typed_data';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'pass_entry_dao.dart';
import 'pass_entry.dart';

part 'database.g.dart';

@Database(version: 1, entities: [PassEntry])
abstract class AppDatabase extends FloorDatabase {
  PassEntryDao get passEntryDao;
}
