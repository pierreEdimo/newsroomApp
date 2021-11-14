import 'package:flutter/material.dart';
import 'package:newsroom/utilities/constants.dart';

Widget titleRow(
  String title,
  IconButton icon,
  context,
) {
  return Padding(
    padding: horizontalPadding,
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
  );
}
