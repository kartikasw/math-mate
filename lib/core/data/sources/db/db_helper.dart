import 'package:hive_flutter/hive_flutter.dart';
import 'package:math_mate/core/data/sources/db/sqlite_helper.dart';
import 'package:math_mate/core/domain/model/history.dart';
import 'package:sqflite/sqflite.dart';

abstract class DbHelper {
  Future<int> insertHistory(History history);

  Future<List<History>> getHistoryList();

  Future<int> deleteHistory();
}

class DbHelperWithSqlite implements DbHelper {
  final SqliteHelper _databaseHelper;

  DbHelperWithSqlite(this._databaseHelper);

  @override
  Future<int> deleteHistory() async {
    try {
      return await _databaseHelper.deleteDataOrList(History.tableName);
    } on DatabaseException {
      rethrow;
    }
  }

  @override
  Future<List<History>> getHistoryList() async {
    try {
      return await _databaseHelper.getDataList(
          History.tableName, (map) => History.fromMapObject(map),
          orderBy: '${History.colTimeStamp} DESC');
    } on DatabaseException {
      rethrow;
    }
  }

  @override
  Future<int> insertHistory(History history) async {
    try {
      return await _databaseHelper.insertData(
        History.tableName,
        history.toMap(),
      );
    } on DatabaseException {
      rethrow;
    }
  }
}

class DbHelperWithHive extends DbHelper {
  Box<History>? _historyBox;

  Future<Box<History>> get historyBox async =>
      _historyBox ??= await initializeBox();

  Future<Box<History>> initializeBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HistoryAdapter());
    return await Hive.openBox<History>('histories');
  }

  @override
  Future<int> deleteHistory() async {
    Box<History> box = await historyBox;
    return await box.clear();
  }

  @override
  Future<List<History>> getHistoryList() async {
    Box<History> box = await historyBox;
    return box.values.toList();
  }

  @override
  Future<int> insertHistory(History history) async {
    Box<History> box = await historyBox;
    history.copyWith(id: DateTime.now().microsecondsSinceEpoch);
    await box.add(history);
    return 1;
  }
}
