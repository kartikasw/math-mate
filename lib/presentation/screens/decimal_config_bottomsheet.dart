import 'package:math_mate/common/utils/extensions.dart';
import 'package:math_mate/presentation/bloc/calculator_settings/calculator_settings_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DecimalConfigBottomSheet extends StatefulWidget {
  const DecimalConfigBottomSheet({super.key});

  @override
  State<StatefulWidget> createState() => _DecimalConfigBottomSheetState();
}

class _DecimalConfigBottomSheetState extends State<DecimalConfigBottomSheet> {
  late FixedExtentScrollController _pickerController;

  @override
  void initState() {
    _pickerController = FixedExtentScrollController(
        initialItem:
            context.read<CalculatorSettingsBloc>().state.decimalConfig - 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorSettingsBloc, CalculatorSettingsState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  'Decimal Place',
                  style: context.textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  useMagnifier: true,
                  scrollController: _pickerController,
                  itemExtent: 40.0,
                  onSelectedItemChanged: (value) {},
                  children: List.generate(
                    5,
                    (index) => Text(
                      '${index + 1}',
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
              Container(
                width: context.mediaQuery.size.width,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ElevatedButton(
                  onPressed: () =>
                      _onDecimalPlaceSelect(_pickerController.selectedItem),
                  child: const Text('Save'),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _onDecimalPlaceSelect(int value) {
    BlocProvider.of<CalculatorSettingsBloc>(context)
        .add(CalculatorSettingsEventSetDecimalConfig(value + 1));
    Navigator.pop(context);
  }
}
