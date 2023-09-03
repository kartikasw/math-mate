import 'package:math_mate/injection.dart';
import 'package:math_mate/presentation/bloc/calculator_settings/calculator_settings_bloc.dart';
import 'package:math_mate/presentation/bloc/history/history_bloc.dart';
import 'package:math_mate/presentation/screens/calculator_settings_screen.dart';
import 'package:math_mate/presentation/screens/decimal_config_bottomsheet.dart';
import 'package:math_mate/presentation/screens/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Widget history() {
    Widget nextScreen = BlocProvider(
      create: (context) => locator<HistoryBloc>(),
      child: const HistoryScreen(),
    );
    return nextScreen;
  }

  static Widget calculatorSettings() {
    Widget nextScreen = BlocProvider(
      create: (context) => locator<CalculatorSettingsBloc>(),
      child: const CalculatorSettingsScreen(),
    );
    return nextScreen;
  }

  static Widget decimalConfigBottomSheet(
      CalculatorSettingsBloc calculatorSettingsBloc) {
    Widget nextScreen = BlocProvider.value(
      value: calculatorSettingsBloc,
      child: const DecimalConfigBottomSheet(),
    );
    return nextScreen;
  }
}
