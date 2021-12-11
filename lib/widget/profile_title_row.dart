import 'package:flutter/material.dart';
import 'package:newsroom/utilities/constants.dart';

Widget profileTitleRow() {
  return Padding(
    padding: horizontalPadding,
    child: Center(
        child: Text(
      "Settings",
      style: titleStyle,
    )),
  );
}
