import 'package:flutter/foundation.dart';
import "package:sqflite/sqflite.dart";

import '../models/task.dart';

class DBhelper{
  static Database? _db;
  static const int _version = 1;
  static const String _tablename = "tasks_DailyBuffer";

  static Future<void> initDB() async{
    if(_db != null){
      return;
    }
    try{
      String path = "${await getDatabasesPath()}tasks_DailyBuffer.db";
      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version){
          return db.execute(
            "CREATE TABLE $_tablename ("
                "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                "title STRING,"
                "note TEXT,"
                "date STRING,"
                "startTime STRING,"
                "endTime STRING,"
                "remind INTEGER,"
                "repeat STRING,"
                "color INTEGER,"
                "isCompleted INTEGER)",
          );
        }
      );
    }catch(err){
      if (kDebugMode) {
        print(err);
      }
    }
  }

  static Future<int> insert(Task task) async{
    return await _db!.insert(_tablename, task.toJson());
  }

  static Future<List<Map<String, dynamic>>> query() async{
    return await _db!.query(_tablename);
  }

  static delete(Task task)async{
    return await _db!.delete(_tablename, where: "id=?", whereArgs: [task.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate("UPDATE tasks_DailyBuffer SET isCompleted=? WHERE id=?",[1,id]);
  }

  static undoUpdate(int id) async {
    return await _db!.rawUpdate("UPDATE tasks_DailyBuffer SET isCompleted=? WHERE id=?",[0,id]);
  }
}