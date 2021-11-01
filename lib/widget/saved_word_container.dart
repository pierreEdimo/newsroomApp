import 'package:flutter/material.dart';

Widget savedWordContainer(String savedWord) {
  return Card(
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: [
          Icon(Icons.history_outlined),
          SizedBox(
            width: 25.0,
          ),
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
