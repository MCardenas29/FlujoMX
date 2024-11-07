import 'package:FlujoMX/database.dart';
import 'package:FlujoMX/entity/profile.dart';
import 'package:sqflite/sqflite.dart';

final class ProfileRepo extends Repository<Profile> {
  @override
  Future<void> delete(Profile entity) async {
    final db = await database;
    await db
        .delete(Profile.TABLE, where: "rowid = ?", whereArgs: [entity.rowId]);
  }

  @override
  Future<Profile?> fetch(int rowId) async {
    final db = await database;
    final results =
        await db.query(Profile.TABLE, where: 'rowid = ?', whereArgs: [rowId]);
    print(results.first);
    return results.isEmpty ? null : Profile.fromMap(results.first);
  }

  @override
  Future<int> save(Profile entity) async {
    final db = await database;
    return await db.insert(Profile.TABLE, entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
