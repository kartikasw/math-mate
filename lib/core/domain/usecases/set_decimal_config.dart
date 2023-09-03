import 'package:math_mate/common/utils/failure.dart';
import 'package:math_mate/core/domain/app_repository.dart';
import 'package:dartz/dartz.dart';

class SetDecimalConfig {
  final AppRepository appRepository;

  SetDecimalConfig(this.appRepository);

  Future<Either<Failure, String>> execute(int value) =>
      appRepository.setDecimalPointConfig(value);
}