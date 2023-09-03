import 'package:math_mate/core/domain/model/history.dart';
import 'package:sqflite/sqflite.dart';

typedef ModelElement<T> = T Function(Map<String, dynamic>);

class SqliteHelper {
  Database? _database;

  Future<Database> get database async => _database ??= await initializeDb();

  Future<Database> initializeDb() async {
    String path = await getDatabasesPath();
    Database database = await openDatabase('$path/kelilink.db',
        onCreate: _onCreate, version: 1);
    return database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(History.createTableQuery());
  }

  Future<int> insertData(String tableName, Map<String, dynamic> data) async {
    final Database db = await database;
    return await db.insert(tableName, data);
  }

  Future<T?> getData<T>(
    String tableName,
    ModelElement<T> mapping, {
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final Database db = await database;
    final List<Map<String, dynamic>> list = await db.query(
      tableName,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
    );

    if (list.isNotEmpty) {
      return mapping(list[0]);
    } else {
      return null;
    }
  }

  Future<int> updateData(
    String tableName,
    Map<String, dynamic> data,
    String column,
    dynamic value,
  ) async {
    final Database db = await database;
    return await db
        .update(tableName, data, where: '$column = ?', whereArgs: [value]);
  }

  Future<void> insertDataList(
      List<Map<String, dynamic>> dataList, String tableName) async {
    final Database db = await database;
    db.transaction((txn) async {
      for (Map<String, dynamic> data in dataList) {
        txn.insert(tableName, data);
      }
    });
  }

  Future<List<T>> getDataList<T>(
    String tableName,
    ModelElement<T> mapping, {
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
  }) async {
    final Database db = await database;
    return (await db.query(tableName,
            columns: columns,
            where: where,
            whereArgs: whereArgs,
            orderBy: orderBy))
        .map(mapping)
        .toList();
  }

  Future<int> deleteDataOrList(String tableName,
      {String? where, List<Object?>? whereArgs}) async {
    Database db = await database;
    return await db.delete(tableName, where: where, whereArgs: whereArgs);
  }
}
