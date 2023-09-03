import 'package:math_mate/common/utils/app_router.dart';
import 'package:math_mate/common/utils/extensions.dart';
import 'package:math_mate/presentation/bloc/calculator_settings/calculator_settings_bloc.dart';
import 'package:math_mate/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorSettingsScreen extends StatefulWidget {
  const CalculatorSettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CalculatorSettingsScreenState();
}

class _CalculatorSettingsScreenState extends State<CalculatorSettingsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onGetHistoryConfig();
      _onGetDecimalConfig();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(context, 'Calculator Settings'),
      body: BlocBuilder<CalculatorSettingsBloc, CalculatorSettingsState>(
        builder: (context, state) => Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: context.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildSubMenuButton(
                'Keep the Last Record',
                Switch(
                  value: state.historyConfig,
                  activeColor: context.colorScheme.primary,
                  onChanged: (value) => _onSetHistoryConfig(value),
                ),
                start: true,
              ),
              GestureDetector(
                onTap: _onDecimalConfigClick,
                child: _buildSubMenuButton(
                  'Decimal Place',
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          state.decimalConfig.toString(),
                          style: context.textTheme.titleMedium,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                  end: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubMenuButton(String title, Widget decoration,
      {bool start = false, bool end = false}) {
    Widget mainWidget = Padding(
      padding: !start && !end
          ? const EdgeInsets.symmetric(vertical: 15)
          : start
              ? const EdgeInsets.only(bottom: 15)
              : const EdgeInsets.only(top: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: context.textTheme.titleMedium,
            ),
          ),
          decoration
        ],
      ),
    );
    if (start) {
      return Column(
        children: <Widget>[mainWidget, const Divider(thickness: 0.5)],
      );
    } else if (end) {
      return mainWidget;
    } else {
      return Column(
        children: <Widget>[mainWidget, const Divider(thickness: 0.5)],
      );
    }
  }

  void _onDecimalConfigClick() {
    showModalBottomSheet<void>(
      context: context,
      builder: (bottomSheetContext) {
        return AppRouter.decimalConfigBottomSheet(
            context.read<CalculatorSettingsBloc>());
      },
    );
  }

  void _onSetHistoryConfig(bool value) {
    BlocProvider.of<CalculatorSettingsBloc>(context).add(
      CalculatorSettingsEventSetHistoryConfig(value),
    );
  }

  void _onGetHistoryConfig() {
    BlocProvider.of<CalculatorSettingsBloc>(context).add(
      CalculatorSettingsEventGetHistoryConfig(),
    );
  }

  void _onGetDecimalConfig() {
    BlocProvider.of<CalculatorSettingsBloc>(context).add(
      CalculatorSettingsEventGetDecimalConfig(),
    );
  }
}
