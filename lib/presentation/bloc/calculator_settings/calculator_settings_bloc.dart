import 'package:math_mate/common/utils/failure.dart';
import 'package:math_mate/core/domain/usecases/get_decimal_config.dart';
import 'package:math_mate/core/domain/usecases/get_history_config.dart';
import 'package:math_mate/core/domain/usecases/set_decimal_config.dart';
import 'package:math_mate/core/domain/usecases/set_history_config.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calculator_settings_event.dart';

part 'calculator_settings_state.dart';

class CalculatorSettingsBloc
    extends Bloc<CalculatorSettingsEvent, CalculatorSettingsState> {
  final SetHistoryConfig _setHistoryConfig;
  final GetHistoryConfig _getHistoryConfig;
  final SetDecimalConfig _setDecimalConfig;
  final GetDecimalConfig _getDecimalConfig;

  CalculatorSettingsBloc(this._setHistoryConfig, this._getHistoryConfig,
      this._setDecimalConfig, this._getDecimalConfig)
      : super(const CalculatorSettingsStateInitial()) {
    on<CalculatorSettingsEventGetHistoryConfig>(
        _onCalculatorSettingsEventGetHistoryConfig);
    on<CalculatorSettingsEventSetHistoryConfig>(
        _onCalculatorSettingsEventSetHistoryConfig);
    on<CalculatorSettingsEventGetDecimalConfig>(
        _onCalculatorSettingsEventGetDecimalConfig);
    on<CalculatorSettingsEventSetDecimalConfig>(
        _onCalculatorSettingsEventSetDecimalConfig);
  }

  Future<void> _onCalculatorSettingsEventGetHistoryConfig(
      CalculatorSettingsEventGetHistoryConfig event,
      Emitter<CalculatorSettingsState> emit) async {
    bool result = await _getHistoryConfig.execute();
    emit(CalculatorSettingsStateGetHistoryConfigSuccess(
        historyConfig: result, decimalConfig: state.decimalConfig));
  }

  Future<void> _onCalculatorSettingsEventSetHistoryConfig(
      CalculatorSettingsEventSetHistoryConfig event,
      Emitter<CalculatorSettingsState> emit) async {
    Either<Failure, String> result =
        await _setHistoryConfig.execute(event.value);
    result.fold(
        (failure) => emit(CalculatorSettingsStateError(failure.message,
            historyConfig: state.historyConfig,
            decimalConfig: state.decimalConfig)),
        (result) => emit(CalculatorSettingsStateHistoryConfigSet(
            historyConfig: event.value, decimalConfig: state.decimalConfig)));
  }

  Future<void> _onCalculatorSettingsEventGetDecimalConfig(
      CalculatorSettingsEventGetDecimalConfig event,
      Emitter<CalculatorSettingsState> emit) async {
    int result = await _getDecimalConfig.execute();
    emit(CalculatorSettingsStateGetHistoryConfigSuccess(
        historyConfig: state.historyConfig, decimalConfig: result));
  }

  Future<void> _onCalculatorSettingsEventSetDecimalConfig(
      CalculatorSettingsEventSetDecimalConfig event,
      Emitter<CalculatorSettingsState> emit) async {
    Either<Failure, String> result =
        await _setDecimalConfig.execute(event.value);
    result.fold(
        (failure) => emit(CalculatorSettingsStateError(failure.message,
            historyConfig: state.historyConfig,
            decimalConfig: state.decimalConfig)),
        (result) => emit(CalculatorSettingsStateDecimalConfigSet(
            historyConfig: state.historyConfig, decimalConfig: event.value)));
  }
}
