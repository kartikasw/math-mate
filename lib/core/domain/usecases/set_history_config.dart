import 'package:math_mate/common/utils/failure.dart';
import 'package:math_mate/core/domain/app_repository.dart';
import 'package:dartz/dartz.dart';

class SetHistoryConfig {
  final AppRepository appRepository;

  SetHistoryConfig(this.appRepository);

  Future<Either<Failure, String>> execute(bool value) =>
      appRepository.setHistoryConfig(value);
}