import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  FocusScopeNode get focusScope => FocusScope.of(this);

  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;
}