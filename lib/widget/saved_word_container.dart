import 'package:flutter/material.dart';
import 'package:newsroom/utilities/constants.dart';

Widget savedWordContainer(String savedWord) {
  return Card(
    child: Padding(
      padding: EdgeInsets.all(15.0),
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
    ),
  );
}
