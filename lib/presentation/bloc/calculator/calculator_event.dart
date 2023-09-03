part of 'calculator_bloc.dart';

class CalculatorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CalculatorEventCommandClick extends CalculatorEvent {
  final Command command;
  final int cursorOffset;

  CalculatorEventCommandClick(this.command, this.cursorOffset);
}

class CalculatorEventCalculateInput extends CalculatorEvent {}

class CalculatorEventUpdateInput extends CalculatorEvent {
  final String input;

  CalculatorEventUpdateInput(this.input);
}

class CalculatorEventInputClick extends CalculatorEvent {}

class CalculatorEventResultClick extends CalculatorEvent {}
