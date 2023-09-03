
import 'package:flutter/material.dart';

class ColorRes {
  static const Color black = Colors.black;
  static const Color white = Colors.white;

  static const Color orange500 = Color(0xFFFF9501);
  static const Color orange900 = Color(0xffff7d01);

  static const Color blue700 = Color(0xFF0173FE);

  static const Color green700 = Color(0xff66a942);

  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey400 = Color(0xFFB9B9C1);
  static const Color grey900a = Color(0xFF2C2C2E);
  static const Color grey900b = Color(0xFF1D1D1F);
  static const Color grey900c = Color(0xFF2F2F31);

  static const Color red900 = Color(0xFFA93130);

  static const ColorScheme darkColors = ColorScheme(
      brightness: Brightness.dark,
      primary: orange500,
      onPrimary: grey900c,
      secondary: grey400,
      onSecondary: black,
      secondaryContainer: grey900c,
      onSecondaryContainer: white,
      error: red900,
      onError: white,
      background: black,
      onBackground: white,
      surface: grey900b,
      onSurface: white);
}