import 'package:app/db/pass_entry.dart';
import 'package:floor/floor.dart';

@dao
abstract class PassEntryDao {
  @Query('SELECT * FROM PassEntry')
  Future<List<PassEntry>> findAll();

  @insert
  Future<void> insertPassEntry(PassEntry entry);

  @Query('DELETE FROM PassEntry WHERE id = :serial')
  Future<void> deletePassEntry(String serial);
}
