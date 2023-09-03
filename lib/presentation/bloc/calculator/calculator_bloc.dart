import 'package:math_mate/common/utils/enumeration/command_type_enum.dart';
import 'package:math_mate/common/utils/failure.dart';
import 'package:math_mate/core/domain/usecases/calculate_operation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_mate/common/utils/enumeration/command_enum.dart';
import 'package:equatable/equatable.dart';

part 'calculator_event.dart';

part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final CalculateOperation _calculateOperation;

  CalculatorBloc(this._calculateOperation) : super(const CalculatorStateInitial()) {
    on<CalculatorEventCommandClick>(_onCalculatorEventCommandClick);
    on<CalculatorEventCalculateInput>(_onCalculatorEventCalculateInput);
    on<CalculatorEventUpdateInput>(_onCalculatorEventUpdateInput);
    on<CalculatorEventInputClick>(_onCalculatorEventInputClick);
    on<CalculatorEventResultClick>(_onCalculatorEventResultClick);
  }

  Future<void> _onCalculatorEventCommandClick(
      CalculatorEventCommandClick event, Emitter<CalculatorState> emit) async {
    String newInput = '';
    if (event.command.type == CommandType.number) {
      if (state.input.length < 15) {
        if (event.cursorOffset == -1) {
          newInput = state.input + event.command.symbol!;
        } else if (event.cursorOffset == 0) {
          newInput = event.command.symbol! + state.input;
        } else {
          newInput = state.input.substring(0, event.cursorOffset) +
              event.command.symbol!;
          newInput +=
              state.input.substring(event.cursorOffset, state.input.length);
        }
      } else {
        newInput = state.input;
      }
    } else {
      if (event.command == Command.delete) {
        if (event.cursorOffset == -1) {
          if (state.input.isNotEmpty) {
            newInput = state.input.substring(0, state.input.length - 1);
          }
        } else if (event.cursorOffset == 0) {
          newInput = state.input;
        } else {
          int deletedIndex = event.cursorOffset - 1;
          newInput = state.input.substring(0, deletedIndex);
          newInput +=
              state.input.substring(event.cursorOffset, state.input.length);
        }
      }
    }
    emit(CalculatorStateCommandClicked(
      event.command,
      event.cursorOffset,
      input: newInput,
      result: event.command == Command.clear ? '' : state.result,
    ));
    emit(CalculatorStateInitial(
      input: newInput,
      result: state.result,
    ));
  }

  Future<void> _onCalculatorEventCalculateInput(
      CalculatorEventCalculateInput event,
      Emitter<CalculatorState> emit) async {
    Either<Failure, String> result =
        await _calculateOperation.execute(state.input);
    result.fold(
        (failure) => emit(CalculatorStateError(
              failure.message,
              input: state.input,
              result: 'Error',
            )), (result) {
      emit(CalculatorStateCalculateInput(input: state.input, result: result));
      emit(CalculatorStateInitial(input: state.input, result: state.result));
    });
  }

  Future<void> _onCalculatorEventUpdateInput(
      CalculatorEventUpdateInput event, Emitter<CalculatorState> emit) async {
    emit(CalculatorStateInputUpdated(input: event.input));
    emit(CalculatorStateInitial(
      input: state.input,
      result: state.result,
    ));
  }

  Future<void> _onCalculatorEventInputClick(
      CalculatorEventInputClick event, Emitter<CalculatorState> emit) async {
    emit(CalculatorStateInputClicked(
      input: state.input,
      result: state.result,
    ));
    emit(CalculatorStateInitial(
      input: state.input,
      result: state.result,
    ));
  }

  Future<void> _onCalculatorEventResultClick(
      CalculatorEventResultClick event, Emitter<CalculatorState> emit) async {
    emit(CalculatorStateResultClicked(
      input: state.input,
      result: state.result,
    ));
    emit(CalculatorStateInitial(
      input: state.input,
      result: state.result,
    ));
  }
}
