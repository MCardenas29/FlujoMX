import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Entity interface
abstract class Entity {
  int? rowId;
  Entity({this.rowId});

  Map<String, Object?> toMap();
  Entity.fromMap(Map<String, Object?> data);
}

abstract class Repository {
  static Future<Database>? _instance;
  String get TABLE;

  Repository() {
    if (_instance == null) _init();
  }

  static void _init() async {
    _instance ??= openDatabase(join(await getDatabasesPath(), "flow.db"),
        onCreate: _onCreate, version: 1);
  }

  Future<bool> save(Entity entity) async {
    final database = await _instance;
    database?.insert(TABLE, entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return true;
  }

  Future<bool> delete(Entity entity) async {
    final database = await _instance;
    database?.delete(TABLE, where: "row_id = ?", whereArgs: [entity.rowId]);
    return true;
  }

  Future<Entity?> fetch(int rowId) async {
    final database = await _instance;
    final result =
        (await database?.query(TABLE, where: "row_id = ?", whereArgs: [rowId]));
    return result!.isEmpty ? null : fromMap(result.first);
  }
}

// --- Migrations
Future<void> _onCreate(Database db, int version) async {
  if (version == 1) {
    db.execute("CREATE TABLE flow(timestamp INTEGER, value DOUBLE NOT NULL)");
    db.execute(
        "CREATE TABLE profile(name VARCHAR, email VARCHAR, currentFee INT)");
  }
}
