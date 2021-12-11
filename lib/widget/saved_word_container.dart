import 'package:flutter/material.dart';
import 'package:newsroom/utilities/constants.dart';

Widget savedWordContainer(String savedWord) {
  return Padding(
    padding: verticalPadding,
    child: Row(
      children: [
        Icon(Icons.history_outlined),
        horizontalSpace,
        Text(
          savedWord,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
