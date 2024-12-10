import 'package:FlujoMX/entity/profile.dart';
import 'package:FlujoMX/provider/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
part '../generated/repository/profile.g.dart';

final class ProfileRepository {
  Database _db;
  ProfileRepository({required Database db}) : _db = db;

  Future<void> delete(Profile entity) async {
    await _db.delete(Profile.TABLE, where: "id = ?", whereArgs: [entity.id]);
  }

  Future<Profile?> fetch(int id) async {
    final results =
        await _db.query(Profile.TABLE, where: "id = ?", whereArgs: [id]);
    return results.isEmpty ? null : Profile.fromJson(results.first);
  }

  Future<Profile> save(Profile entity) async {
    final id = await _db.insert(Profile.TABLE, entity.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return entity.copyWith(id: id);
  }
}

@Riverpod(dependencies: [database])
ProfileRepository profileRepository(Ref ref) {
  final database = ref.read(databaseProvider);
  return ProfileRepository(db: database);
}
