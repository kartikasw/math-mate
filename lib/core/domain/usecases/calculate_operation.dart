import 'package:math_mate/common/utils/failure.dart';
import 'package:math_mate/core/domain/app_repository.dart';
import 'package:math_mate/core/domain/model/math_expression.dart';
import 'package:dartz/dartz.dart';
import 'package:simple_expressions/simple_expressions.dart';

class CalculateOperation {
  final AppRepository appRepository;

  CalculateOperation(this.appRepository);

  Future<Either<Failure, String>> execute(String expression) async {
    try {
      MathExpression input = MathExpression(expression);
      input.replaceAll('×', '*');
      input.replaceAll('÷', '/');
      double operationResult = SimpleExpression().evaluate(input.expression);
      int decimalPlace = await appRepository.getDecimalPointConfig();

      if (operationResult % 1 == 0) {
        return Right(operationResult.toStringAsFixed(0));
      } else {
        return Right(operationResult.toStringAsFixed(decimalPlace));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
