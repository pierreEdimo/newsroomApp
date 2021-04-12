import 'package:flutter/material.dart';
import 'package:newsroom/utilities/constants.dart';

Widget inTheCenter(String title) {
  return SafeArea(
    child: Center(
      child: Text(
        title,
        style: titleStyle,
      ),
    ),
  );
}
