import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database>? _instance;
Future<Database> _getInstance() async {
  _instance ??= openDatabase(join(await getDatabasesPath(), "flow.db"),
      onCreate: _onCreate, version: 1);
  return await _instance!;
}

// --- Migrations
Future<void> _onCreate(Database db, int version) async {
  if (version == 1) {
    db.execute(
        "CREATE TABLE flow(id INTEGER PRIMARY KEY AUTOINCREMENT, timestamp INTEGER, value DOUBLE NOT NULL)");
    db.execute(
        "CREATE TABLE profile(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR, email VARCHAR, currentFee INT)");
  }
}

// Entity interface
abstract class Entity {
  int? _id;
  Entity({int? id}) : _id = id;

  int? get id => _id;

  Map<String, Object?> toMap();
  Entity.fromMap(Map<String, Object?> data);
}

abstract base class Repository<T extends Entity> {
  Future<Database> database;
  Repository() : database = _getInstance();

  Future<T?> save(T entity);
  Future<void> delete(T entity);
  Future<T?> fetch(int id);
}
