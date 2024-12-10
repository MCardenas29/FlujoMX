import 'package:FlujoMX/entity/flow.dart';
import 'package:FlujoMX/provider/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
part '../generated/repository/flow.g.dart';

final class FlowRepository {
  Database _db;
  FlowRepository({required Database db}) : _db = db;

  Future<List<Flow>> all() async {
    var list = <Flow>[];
    var result = await _db.query(Flow.TABLE);
    for (final item in result) {
      list.add(Flow.fromJson(item));
    }
    return list;
  }

  Future<void> delete(Flow entity) async {
    await _db.delete(Flow.TABLE, where: "id = ?", whereArgs: [entity.id]);
  }

  Future<Flow?> fetch(int id) async {
    final results =
        await _db.query(Flow.TABLE, where: "id = ?", whereArgs: [id]);
    return results.isEmpty ? null : Flow.fromJson(results.first);
  }

  Future<Flow> save(Flow entity) async {
    final id = await _db.insert(Flow.TABLE, entity.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return entity.copyWith(id: id);
  }

  Future<double> getUsage() async {
    final sum =
        await _db.rawQuery("SELECT SUM(value) AS total FROM ${Flow.TABLE}");
    return sum.first['total'] as double;
  }
}

@Riverpod(dependencies: [database])
FlowRepository flowRepository(Ref ref) {
  final database = ref.read(databaseProvider);
  return FlowRepository(db: database);
}
