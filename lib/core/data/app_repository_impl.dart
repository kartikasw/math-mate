import 'package:math_mate/common/utils/failure.dart';
import 'package:math_mate/core/data/sources/db/db_helper.dart';
import 'package:math_mate/core/data/sources/shared_pref/shared_pref.dart';
import 'package:math_mate/core/domain/app_repository.dart';
import 'package:math_mate/core/domain/model/history.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

class AppRepositoryImpl implements AppRepository {
  final DbHelper _dbHelper;
  final SharedPref _sharedPref;

  AppRepositoryImpl(this._dbHelper, this._sharedPref);

  @override
  Future<Either<Failure, int>> deleteHistory() async {
    try {
      final int result = await _dbHelper.deleteHistory();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<History>>> getHistoryList() async {
    try {
      final List<History> result = await _dbHelper.getHistoryList();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> insertHistory(History history) async {
    try {
      final int result = await _dbHelper.insertHistory(history);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> setHistoryConfig(bool value) async {
    try {
      await _sharedPref.setBool(key: 'history_config', value: value);
      return const Right('Set history point config succeeded');
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<bool> getHistoryConfig() async {
    bool? result = _sharedPref.getBool('history_config');
    if (result != null) {
      return result;
    } else {
      return false;
    }
  }

  @override
  Future<Either<Failure, String>> setDecimalPointConfig(int value) async {
    try {
      await _sharedPref.setInt(key: 'decimal_config', value: value);
      return const Right('Set decimal point config succeeded');
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<int> getDecimalPointConfig() async {
    int? result = _sharedPref.getInt('decimal_config');
    if (result != null) {
      return result;
    } else {
      return 3;
    }
  }
}
