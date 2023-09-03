import 'package:math_mate/common/utils/failure.dart';
import 'package:math_mate/core/domain/app_repository.dart';
import 'package:math_mate/core/domain/model/history.dart';
import 'package:dartz/dartz.dart';

class InsertHistory {
  final AppRepository appRepository;

  InsertHistory(this.appRepository);

  Future<Either<Failure, int>> execute(History history) async {
    bool historyConfig = await appRepository.getHistoryConfig();
    if (historyConfig) {
      return appRepository.insertHistory(history);
    } else {
      return const Right(0);
    }
  }
}
