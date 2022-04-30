import 'package:flutter/material.dart';

class CustomThemes {
  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(),
    scaffoldBackgroundColor: Color(0xFF000000),
    fontFamily: 'Poppins'
        '',
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: Colors.white),
    appBarTheme: darkAppBarTheme,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.white,
      ),
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    fontFamily: 'Poppins',
    appBarTheme: lightAppBarTheme,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.black,
      ),
    ),
  );
}

AppBarTheme lightAppBarTheme = AppBarTheme(
  color: Color(0xe9e9e9e9),
  titleTextStyle: TextStyle(
    color: Color(0xFF000000),
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    fontFamily: "PoppinsBold"
  )
);

AppBarTheme darkAppBarTheme = AppBarTheme(
  color: Color(0xFF000000),
    titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        fontFamily: "PoppinsBold"
    )
);