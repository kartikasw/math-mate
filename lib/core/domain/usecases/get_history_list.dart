import 'package:math_mate/common/utils/failure.dart';
import 'package:math_mate/core/domain/app_repository.dart';
import 'package:math_mate/core/domain/model/history.dart';
import 'package:dartz/dartz.dart';

class GetHistoryList {
  final AppRepository appRepository;

  GetHistoryList(this.appRepository);

  Future<Either<Failure, List<History>>> execute() =>
      appRepository.getHistoryList();
}
