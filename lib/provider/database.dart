import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
part '../generated/provider/database.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
Database database(Ref ref) => throw UnimplementedError();

Future<Database> openDb() async {
  return openDatabase(join(await getDatabasesPath(), "flow.db"),
      onCreate: _onCreate, version: 1);
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
