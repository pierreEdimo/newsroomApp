import 'package:flutter/material.dart';

Widget readingTime() {
  return Row(
    children: [
      Text(
        "3",
        style: TextStyle(fontFamily: 'OpenSansBold'),
      ),
      SizedBox(
        width: 5.0,
      ),
      Text(
        "MIN",
        style: TextStyle(fontFamily: 'OpenSansBold'),
      ),
    ],
  );
}
