import 'package:flutter/material.dart';

Widget listTile(
  Icon icon,
  String title,
) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 25.0,
      top: 20.0,
      bottom: 20.0,
      right: 25.0,
    ),
    child: Row(
      children: [
        icon,
        SizedBox(
          width: 20.0,
        ),
        Text(title),
      ],
    ),
  );
}
