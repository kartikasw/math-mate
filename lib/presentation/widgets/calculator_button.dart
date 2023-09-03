import 'package:math_mate/common/utils/enumeration/command_enum.dart';
import 'package:math_mate/common/utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final Command command;
  final Function(Command) onCommandTap;
  final Function() onCalculate;

  const CalculatorButton(this.command,
      {required this.onCommandTap, required this.onCalculate, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (command == Command.calculate) {
          onCalculate();
        } else {
          onCommandTap(command);
        }
      },
      child: Container(
        width: kIsWeb ? 480 / 4 : context.mediaQuery.size.width / 4,
        height: context.mediaQuery.size.height * 0.5 / 5,
        padding: const EdgeInsets.all(5),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: command.background,
            borderRadius: BorderRadius.circular(15),
          ),
          child: command.symbol != null
              ? Text(
                  command.symbol!,
                  style: context.textTheme.titleLarge
                      ?.copyWith(color: command.foreground),
                )
              : Icon(command.icon),
        ),
      ),
    );
  }
}
