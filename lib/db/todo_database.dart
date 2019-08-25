import 'package:flutter_app_sqlite/db/todo_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TodoDatabase {
  static const String DB_NAME = 'todo.db';
  static const int DB_VERSION = 1;
  static Database _database;

  TodoDatabase._internal();
  static final TodoDatabase instance = TodoDatabase._internal();

  static const initScript = [TodoTable.CREATE_TABLE_QUERY];
  static const migrationScripts = [TodoTable.DROP_TABLE_QUERY];

  init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      onCreate: (db, version) {
        initScript.forEach((script) async => await db.execute(script));
      },
      onUpgrade: (db, oldVersion, newVersion) {
        print("onUpgrade Database");
        migrationScripts.forEach((script) async => await db.execute(script));
        initScript.forEach((script) async => await db.execute(script));
      },
      version: 5,
    );
  }

  Database get database => _database;
}
