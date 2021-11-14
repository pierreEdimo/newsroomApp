import 'package:flutter/material.dart';
import 'package:newsroom/utilities/constants.dart';

Widget listTile(
  Icon icon,
  String title,
) {
  return Padding(
    padding: completePadding,
    child: Row(
      children: [
        icon,
        horizontalSpace,
        Text(title),
      ],
    ),
  );
}
