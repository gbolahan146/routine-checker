import 'package:flutter/material.dart';
import 'package:routinechecker/src/config/styles/colors.dart';

class ThemeConfig {
  static AppBarTheme appBarTheme = AppBarTheme(
      color: CbColors.white,
      iconTheme: IconThemeData(
        color: CbColors.cAccentBase,
      ));

  static ThemeData defaultTheme = ThemeData(
    primaryColor: CbColors.cPrimaryBase,
    appBarTheme: appBarTheme,
    dividerTheme: DividerThemeData(color: Colors.transparent),
    brightness: Brightness.light,
  );
}
