import 'package:flutter/material.dart';

class CustomThemes {
  static final darkTheme = ThemeData(
      colorScheme: ColorScheme.dark(),
      fontFamily: 'OpenSans',
      brightness: Brightness.dark,
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: Colors.white,
      )));

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(),
      fontFamily: 'OpenSans',
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: Colors.black
      ),

      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: Colors.black,
      )));
}
