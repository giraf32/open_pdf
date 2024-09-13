import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class InitDb {
  InitDb._();
  static InitDb? _initDb;
  static Database? _database;

  factory InitDb.create() {
    return _initDb ??= InitDb._();
  }
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _createDb();
    return _database;
  }

  _createDb() async {
    try {
      return await openDatabase(
        join(await getDatabasesPath(), 'pdf_database'),
        onCreate: (Database db, version) async {
           await db.execute(
              'CREATE TABLE pdf (id INTEGER PRIMARY KEY, path TEXT, name TEXT, favourites INTEGER, '
              'dateTime TEXT, size TEXT , folder TEXT)');
           await db.execute('CREATE TABLE folder (id INTEGER PRIMARY KEY, nameFolder TEXT)');
        },
        version: 1,
      );
    } catch (ex) {
      print('_createDb $ex');
    }
  }
}
