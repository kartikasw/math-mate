import 'package:math_mate/common/utils/failure.dart';
import 'package:math_mate/core/domain/model/history.dart';
import 'package:dartz/dartz.dart';

abstract class AppRepository {
  Future<Either<Failure, int>> insertHistory(History history);

  Future<Either<Failure, List<History>>> getHistoryList();

  Future<Either<Failure, int>> deleteHistory();

  Future<Either<Failure, String>> setHistoryConfig(bool value);

  Future<bool> getHistoryConfig();

  Future<Either<Failure, String>> setDecimalPointConfig(int value);

  Future<int> getDecimalPointConfig();
}
