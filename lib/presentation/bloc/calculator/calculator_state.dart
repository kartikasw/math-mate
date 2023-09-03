part of 'calculator_bloc.dart';

class CalculatorState extends Equatable {
  final String input;
  final String result;

  const CalculatorState({this.input = '', this.result = ''});

  @override
  List<Object?> get props => [input, result];
}

class CalculatorStateInitial extends CalculatorState {
  const CalculatorStateInitial({super.input, super.result});
}

class CalculatorStateCommandClicked extends CalculatorState {
  final Command command;
  final int cursorOffset;

  const CalculatorStateCommandClicked(
    this.command,
    this.cursorOffset, {
    super.input,
    super.result,
  });
}

class CalculatorStateCalculateInput extends CalculatorState {
  const CalculatorStateCalculateInput({super.input, super.result});
}

class CalculatorStateInputUpdated extends CalculatorState {
  const CalculatorStateInputUpdated({super.input, super.result});
}

class CalculatorStateInputClicked extends CalculatorState {
  const CalculatorStateInputClicked({super.input, super.result});
}

class CalculatorStateResultClicked extends CalculatorState {
  const CalculatorStateResultClicked({super.input, super.result});
}

class CalculatorStateError extends CalculatorState {
  final String errMessage;

  const CalculatorStateError(
    this.errMessage, {
    super.input,
    super.result,
  });

  @override
  List<Object?> get props => [errMessage, input, result];
}
