part of 'calculator_settings_bloc.dart';

class CalculatorSettingsState extends Equatable {
  final bool historyConfig;
  final int decimalConfig;

  const CalculatorSettingsState(
      {this.historyConfig = true, this.decimalConfig = 3});

  @override
  List<Object?> get props => [historyConfig, decimalConfig];
}

class CalculatorSettingsStateInitial extends CalculatorSettingsState {
  const CalculatorSettingsStateInitial(
      {super.historyConfig, super.decimalConfig});
}

class CalculatorSettingsStateGetDecimalConfigSuccess
    extends CalculatorSettingsState {
  const CalculatorSettingsStateGetDecimalConfigSuccess(
      {super.historyConfig, super.decimalConfig});
}

class CalculatorSettingsStateDecimalConfigSet extends CalculatorSettingsState {
  const CalculatorSettingsStateDecimalConfigSet(
      {super.historyConfig, super.decimalConfig});
}

class CalculatorSettingsStateGetHistoryConfigSuccess
    extends CalculatorSettingsState {
  const CalculatorSettingsStateGetHistoryConfigSuccess(
      {super.historyConfig, super.decimalConfig});
}

class CalculatorSettingsStateHistoryConfigSet extends CalculatorSettingsState {
  const CalculatorSettingsStateHistoryConfigSet(
      {super.historyConfig, super.decimalConfig});
}

class CalculatorSettingsStateError extends CalculatorSettingsState {
  final String errMessage;

  const CalculatorSettingsStateError(this.errMessage,
      {super.historyConfig, super.decimalConfig});

  @override
  List<Object?> get props => [errMessage, historyConfig, decimalConfig];
}
