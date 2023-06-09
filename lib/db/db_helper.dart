import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/models/task.dart';

class DBHelpler {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "tasks";

  static Future<void> initDB() async {
    if (_db != null) {
      debugPrint("Not null db");
      return;
    } else {
      try {
        String _path = "${await getDatabasesPath()}tasks.db";
        debugPrint("in Data base path");
        _db = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
          debugPrint("createing anew data base");
          // When creating the db, create the table
          return db.execute('CREATE TABLE $_tableName ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'title STRING, note TEXT , date STRING, '
              'startTime STRING , endTime STRING,'
              'remind INTEGER, repeat STRING ,'
              'color INTEGER, '
              'isCompleted INTEGER)');
        });
        print("Date base create");
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int> insert(Task? task) async {
    debugPrint("insert method is call");
    return await _db!.insert(_tableName, task!.toJson());
  }

  static Future<List<Map<String, dynamic>>> query() async {
    debugPrint("Query method is call");
    return await _db!.query(_tableName);
  }

  static Future<int> delete(Task task) async {
    debugPrint("delete method is call");
    return await _db!.delete(_tableName, where: "id = ?", whereArgs: [task.id]);
  }

  static Future<int> update(int id) async {
    debugPrint("Update method is call");
    return await _db!.rawUpdate('''
      UPDATE tasks
      SET isCompleted = ?
      WHERE id = ? ''', [1, id]);
  }
}
