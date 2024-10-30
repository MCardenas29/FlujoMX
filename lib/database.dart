import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database? _database = null;

Future<Database> getInstance() async {
  _database ??= await openDatabase(join(await getDatabasesPath(), "flow.db"),
      onCreate: _onCreate, version: 1);
  return _database!;
}

Future<void> _onCreate(Database db, int version) async {
  if (version == 1) {
    db.execute(
        "CREATE TABLE flow(timestamp INTEGER NOT NULL, value DOUBLE NOT NULL)");
  }
}
