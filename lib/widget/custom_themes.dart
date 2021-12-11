import 'package:flutter/material.dart';

class CustomThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade800,
      colorScheme: ColorScheme.dark(),
      fontFamily: 'OpenSans',
      brightness: Brightness.dark,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: Colors.white,
      )));

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(),
      fontFamily: 'OpenSans',
      brightness: Brightness.light,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: Colors.black,
      )));
}
