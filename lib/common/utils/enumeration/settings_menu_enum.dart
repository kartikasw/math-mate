import 'package:math_mate/common/resources/icons.dart';

enum SettingsMenu {
  calculatorSettings('Calculator Settings', IconRes.calculator);

  final String _title;
  final String _icon;

  String get title => _title;

  String get icon => _icon;

  const SettingsMenu(this._title, this._icon);
}