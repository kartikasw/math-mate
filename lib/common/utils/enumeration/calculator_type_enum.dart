import 'package:math_mate/common/resources/colors.dart';
import 'package:math_mate/core/domain/model/sub_calculator.dart';
import 'package:flutter/material.dart';

enum CalculatorTypeEnum {
  units('Units\nConverter', ColorRes.orange900, Icons.calculate_rounded, subType: [
    SubCalculator(icon: Icons.balance_rounded, title: 'Mass'),
    SubCalculator(icon: Icons.straighten_rounded, title: 'Length'),
    SubCalculator(icon: Icons.format_shapes_rounded, title: 'Area'),
    SubCalculator(icon: Icons.pie_chart, title: 'Volume'),
    SubCalculator(icon: Icons.timer_rounded, title: 'Time'),
    SubCalculator(icon: Icons.storage_rounded, title: 'Data'),
  ]),
  date('Date\nCalculator', ColorRes.green700, Icons.calendar_month_rounded);

  final String _title;
  final Color _color;
  final IconData _icon;
  final List<SubCalculator>? subType;

  String get title => _title;

  Color get color => _color;

  IconData get icon => _icon;

  const CalculatorTypeEnum(this._title, this._color, this._icon,
      {this.subType = const []});
}
