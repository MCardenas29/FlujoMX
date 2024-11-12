import 'package:FlujoMX/database.dart';
import 'package:FlujoMX/entity/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

final class ProfileRepo extends Repository<Profile> {
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  @override
  Future<void> delete(Profile entity) async {
    final db = await database;
    await db.delete(Profile.TABLE, where: "id = ?", whereArgs: [entity.id]);
  }

  @override
  Future<Profile?> fetch(int id) async {
    final db = await database;
    final results =
        await db.query(Profile.TABLE, where: "id = ?", whereArgs: [id]);
    return results.isEmpty ? null : Profile.fromMap(results.first);
  }

  @override
  Future<Profile> save(Profile entity) async {
    final db = await database;
    final id = await db.insert(Profile.TABLE, entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return entity.copyWith(id: id);
  }

  Future<Profile?> currentProfile() async {
    final profileId = await _preferences.getInt('current_profile') ?? 0;
    if (profileId == 0) return null;
    return await fetch(profileId);
  }
}
