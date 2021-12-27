import 'dart:developer';

import 'package:dev_games/model/game.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "favourite";

  static Future<void> initDB() async {
    if (_db != null) {
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + "Gmaes.db";
        log("path: " + _path, name: "DB");
        _db = await openDatabase(_path, version: 1,
            onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE $_tableName ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'idGame INTEGER, '
              'title STRING, '
              'urlImage STRING '
              ')');
        });
      } catch (e) {
        log("Error: " + e.toString(), name: "DB");
      }
    }
  }

  static Future<int> insert(Game game) async {
    return await _db!.insert(_tableName, game.toJson());
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }
    static Future<int> delete(int idGame) async {
    return await _db!.delete(_tableName, where: "id = ?", whereArgs: [idGame]);
  }
}
