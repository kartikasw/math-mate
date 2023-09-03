part of 'calculator_settings_bloc.dart';

class CalculatorSettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CalculatorSettingsEventGetHistoryConfig extends CalculatorSettingsEvent {}

class CalculatorSettingsEventSetHistoryConfig extends CalculatorSettingsEvent {
  final bool value;

  CalculatorSettingsEventSetHistoryConfig(this.value);
}

class CalculatorSettingsEventGetDecimalConfig extends CalculatorSettingsEvent {}

class CalculatorSettingsEventSetDecimalConfig extends CalculatorSettingsEvent {
  final int value;

  CalculatorSettingsEventSetDecimalConfig(this.value);
}
