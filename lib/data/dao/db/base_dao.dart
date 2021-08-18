import 'package:oplayer/data/model/entity.dart';
import 'package:sqflite/sqflite.dart';
import 'app_db_helper.dart';

class BaseDao<T extends Entity> {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    final Database db = await databaseHelper.database;
    return await db.insert(tableName, row);
  }

  Future<void> insertAll(
      String tableName, List<Map<String, dynamic>> rows) async {
    final Database db = await databaseHelper.database;
    rows.map((row) => db.insert(tableName, row));
  }

  Future<List<T>> findAll(T entity, String tableName) async {
    final Database db = await databaseHelper.database;
    List<Map<String, dynamic>> mapList =
        await db.query(tableName, columns: ["*"], orderBy: "id ASC");
    return List.generate(mapList.length, (index) {
      return entity.fromMap(mapList[index]);
    });
  }

  Future<T> findById(T entity, int id, String tableName) async {
    final Database db = await databaseHelper.database;
    var result = await db.query(tableName, where: "id = ", whereArgs: [id]);
    return result.isNotEmpty ? entity.fromMap(result.first) : Null;
  }

  Future<int> rowCount(String tableName) async {
    final Database db = await databaseHelper.database;
    return Future.value(Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName')));
  }

  Future<int> update(Map<String, dynamic> row, String tableName) async {
    final Database db = await databaseHelper.database;
    int id = row['id'];
    return await db.update(tableName, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id, String tableName) async {
    final Database db = await databaseHelper.database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
