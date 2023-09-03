import 'package:math_mate/core/domain/app_repository.dart';

class GetDecimalConfig {
  final AppRepository appRepository;

  GetDecimalConfig(this.appRepository);

  Future<int> execute() => appRepository.getDecimalPointConfig();
}
