import 'package:math_mate/injection.dart';
import 'package:math_mate/presentation/bloc/calculator/calculator_bloc.dart';
import 'package:math_mate/presentation/bloc/history/history_bloc.dart';
import 'package:math_mate/presentation/bloc/settings/settings_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_mate/common/resources/colors.dart';
import 'package:math_mate/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();

  runApp(_buildRunnableApp(app: const CalculatorApp()));
}

Widget _buildRunnableApp({required Widget app}) {
  if (kIsWeb) {
    return Container(
      color: ColorRes.grey100,
      alignment: Alignment.center,
      child: SizedBox(
        width: 480,
        child: LayoutBuilder(
          builder: (context, constraints) => app,
        ),
      ),
    );
  } else {
    return app;
  }
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MathMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorRes.darkColors,
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorRes.black,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorRes.orange500,
            foregroundColor: ColorRes.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => locator<CalculatorBloc>()),
          BlocProvider(create: (context) => locator<HistoryBloc>()),
          BlocProvider(create: (context) => locator<SettingsBloc>()),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
