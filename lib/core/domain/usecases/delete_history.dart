import 'package:math_mate/common/utils/failure.dart';
import 'package:math_mate/core/domain/app_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteHistory {
  final AppRepository appRepository;

  DeleteHistory(this.appRepository);

  Future<Either<Failure, int>> execute() =>
      appRepository.deleteHistory();
}
