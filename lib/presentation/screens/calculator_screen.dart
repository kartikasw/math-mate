import 'package:math_mate/common/resources/colors.dart';
import 'package:math_mate/common/utils/app_router.dart';
import 'package:math_mate/common/utils/enumeration/command_enum.dart';
import 'package:math_mate/common/utils/enumeration/command_type_enum.dart';
import 'package:math_mate/common/utils/extensions.dart';
import 'package:math_mate/core/domain/model/history.dart';
import 'package:math_mate/presentation/bloc/calculator/calculator_bloc.dart';
import 'package:math_mate/presentation/bloc/history/history_bloc.dart';
import 'package:math_mate/presentation/widgets/calculator_button.dart';
import 'package:math_mate/presentation/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  bool _inputActive = true;

  bool _showCursor = true;

  void _updateInputStatus(bool status) {
    setState(() {
      _inputActive = status;
      _showCursor = status;
    });
  }

  late TextEditingController _inputController;

  @override
  void initState() {
    _inputController = TextEditingController();
    _inputController.text = context.read<CalculatorBloc>().state.input;
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CalculatorBloc, CalculatorState>(
            listener: _onCalculatorBlocListener),
        BlocListener<HistoryBloc, HistoryState>(
            listener: _onHistoryBlocListener),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          BlocBuilder<CalculatorBloc, CalculatorState>(
            builder: (context, state) {
              return Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  alignment: Alignment.bottomRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextField(
                        controller: _inputController,
                        enableInteractiveSelection: _showCursor,
                        onTap: () => _updateInputStatus(true),
                        decoration: InputDecoration(
                          hintText: state.input,
                          counterText: '',
                          border: InputBorder.none,
                        ),
                        style: _inputActive
                            ? context.textTheme.displayMedium
                            : context.textTheme.displaySmall,
                        textAlign: TextAlign.end,
                        maxLength: 15,
                        keyboardType: TextInputType.none,
                        showCursor: _showCursor,
                      ),
                      GestureDetector(
                        onTap: () => _updateInputStatus(false),
                        child: Text(
                          '= ${state.result}',
                          textAlign: TextAlign.right,
                          style: !_inputActive
                              ? context.textTheme.displayMedium
                              : context.textTheme.displaySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: _onHistoryButtonClick,
              child: const Icon(
                Icons.history_rounded,
                color: ColorRes.white,
                size: 35,
              ),
            ),
          ),
          Wrap(
            children: Command.values.map((button) {
              return CalculatorButton(button,
                  onCommandTap: _onCalculatorButtonClick,
                  onCalculate: _onCalculate);
            }).toList(),
          )
        ],
      ),
    );
  }

  void _onCalculatorButtonClick(Command command) {
    BlocProvider.of<CalculatorBloc>(context).add(
      CalculatorEventCommandClick(
        command,
        _inputController.selection.baseOffset,
      ),
    );
  }

  void _onCalculate() {
    BlocProvider.of<CalculatorBloc>(context)
        .add(CalculatorEventCalculateInput());
  }

  void _onHistoryButtonClick() {
    BlocProvider.of<HistoryBloc>(context).add(HistoryEventSeeMoreClick());
  }

  Future<void> _onHistoryBlocListener(
      BuildContext context, HistoryState state) async {
    if (state is HistoryStateSeeMoreClicked) {
      dynamic result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AppRouter.history()),
      );
      if (!mounted) return;
      bool historyClicked = result[0] as bool;
      if (historyClicked) {
        History history = result[1] as History;
        _updateInputStatus(true);
        BlocProvider.of<CalculatorBloc>(context)
            .add(CalculatorEventUpdateInput(history.operation));
        _inputController.text = history.operation;
      }
    } else if (state is HistoryStateError) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => ErrorDialog(state.errMessage),
      );
    }
  }

  Future<void> _onCalculatorBlocListener(
      BuildContext context, CalculatorState state) async {
    if (state is CalculatorStateInitial) {
    } else if (state is CalculatorStateCommandClicked) {
      if (!_inputActive) {
        _updateInputStatus(true);
      }
      _inputController.text = state.input;
      int cursorOffsetAdjustment = state.cursorOffset;
      if (state.command == Command.delete) {
        if (cursorOffsetAdjustment != -1) {
          cursorOffsetAdjustment--;
          if (cursorOffsetAdjustment < 0) {
            cursorOffsetAdjustment = 0;
          }
        }
      } else if (state.command.type == CommandType.number) {
        if (cursorOffsetAdjustment == 0) {
          cursorOffsetAdjustment = -1;
        } else if (cursorOffsetAdjustment != -1) {
          cursorOffsetAdjustment++;
        }
      }
      _inputController.selection = TextSelection.fromPosition(
          TextPosition(offset: cursorOffsetAdjustment));
    } else if (state is CalculatorStateCalculateInput) {
      _updateInputStatus(false);
      BlocProvider.of<HistoryBloc>(context)
          .add(HistoryEventInsertHistory(History(
        operation: state.input,
        result: state.result,
        timestamp: DateTime.now().toString(),
      )));
    } else if (state is CalculatorStateError) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => ErrorDialog(state.errMessage),
      );
    }
  }
}
