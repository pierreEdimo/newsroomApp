import 'package:flutter/material.dart';
import 'package:newsroom/utilities/constants.dart';

Widget titleRow(
  String title,
  IconButton icon,
  context,
) {
  return Padding(
    padding: EdgeInsets.only(left: 25.0, right: 25.0),
    child: SafeArea(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: titleStyle,
            ),
            icon,
          ],
        ),
      ),
    ),
  );
}
