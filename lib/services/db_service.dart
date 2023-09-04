import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/task_model.dart';

class DBService {
  static Database? _db;
  static final int _version = 1;
  static final _tableName = 'tasks';

  static Future<void> initDb() async {

    if (_db != null) {
      print('initDB');
      return;
    }
    try {
      String _path = '${await getDatabasesPath()}tasks.db';
      _db = await openDatabase(_path, version: _version,
          onCreate: (Database db, int version) async {
        return db.execute(
            'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, '
                'taskName TEXT,  isdone INTEGER, date TEXT)');
      });
    } catch (e) {
      print(e);
    }
  }
  static Future<List<Map<String,dynamic>>> queryDate(String date)async{
    return await _db!.query(_tableName,where: 'date = ? ',whereArgs: [date]);
  }

  static Future<List> queryHaveTaskDate()async{
    List s= await _db!.rawQuery("SELECT DISTINCT tasks.date FROM tasks");
    print(s);
    return s;
  }

  static Future<TaskModel> insert(TaskModel task)async {
    print('insert fn');
    task.id = (await _db?.insert(_tableName, task.toJson()))!;
    return task;
  }
  
  static Future<int> update(int id, TaskModel task)async{
    return await _db!.update(_tableName, task.toJson(),where: 'id = ?',whereArgs: [task.id]);
  }
  
  static Future<int> delete(int id)async{
   return await _db!.delete(_tableName,where: 'id = ?',whereArgs: [id]);
  }
}
