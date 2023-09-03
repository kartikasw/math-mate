import 'package:math_mate/core/domain/app_repository.dart';

class GetHistoryConfig {
  final AppRepository appRepository;

  GetHistoryConfig(this.appRepository);

  Future<bool> execute() => appRepository.getHistoryConfig();
}
