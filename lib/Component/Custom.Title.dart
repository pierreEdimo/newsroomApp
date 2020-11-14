import 'package:flutter/material.dart';

Widget listTitle(String title, double fontSize) {
  return Text(
    title,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      fontFamily: 'OpenSans',
    ),
  );
}
