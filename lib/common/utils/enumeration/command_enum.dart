import 'package:math_mate/common/resources/colors.dart';
import 'package:math_mate/common/utils/enumeration/command_type_enum.dart';
import 'package:flutter/material.dart';

enum Command {
  clear(ColorRes.grey900c, ColorRes.orange500, CommandType.operator, symbol: 'AC'),
  percent(ColorRes.grey900c, ColorRes.white, CommandType.number, icon: Icons.percent, symbol: '%'),
  divide(ColorRes.grey900c, ColorRes.white, CommandType.number, symbol: '÷'),
  delete(ColorRes.grey900c, ColorRes.white, CommandType.operator, icon: Icons.backspace_rounded),
  number7(ColorRes.grey400, ColorRes.grey900c, CommandType.number, symbol: '7'),
  number8(ColorRes.grey400, ColorRes.grey900c, CommandType.number, symbol: '8'),
  number9(ColorRes.grey400, ColorRes.grey900c, CommandType.number, symbol: '9'),
  multiply(ColorRes.grey900c, ColorRes.white, CommandType.number, icon: Icons.close_rounded, symbol: '×'),
  number4(ColorRes.grey400, ColorRes.grey900c, CommandType.number, symbol: '4'),
  number5(ColorRes.grey400, ColorRes.grey900c, CommandType.number, symbol: '5'),
  number6(ColorRes.grey400, ColorRes.grey900c, CommandType.number, symbol: '6'),
  subtract(ColorRes.grey900c, ColorRes.white, CommandType.number, icon: Icons.remove_rounded, symbol: '-'),
  number1(ColorRes.grey400, ColorRes.grey900c, CommandType.number, symbol: '1'),
  number2(ColorRes.grey400, ColorRes.grey900c, CommandType.number, symbol: '2'),
  number3(ColorRes.grey400, ColorRes.grey900c, CommandType.number, symbol: '3'),
  add(ColorRes.grey900c, ColorRes.white, CommandType.number, icon: Icons.add, symbol: '+'),
  bracket(ColorRes.grey900c, ColorRes.white, CommandType.number, symbol: '()'),
  number0(ColorRes.grey400, ColorRes.grey900c, CommandType.number, symbol: '0'),
  dot(ColorRes.grey900c, ColorRes.white, CommandType.number, symbol: '.'),
  calculate(ColorRes.orange500, ColorRes.grey900c, CommandType.operator, symbol: '=');

  final Color _background;
  final Color _foreground;
  final CommandType _type;
  final IconData? icon;
  final String? symbol;

  Color get background => _background;
  Color get foreground => _foreground;
  CommandType get type => _type;

  const Command(this._background, this._foreground, this._type, {this.icon, this.symbol});
}
