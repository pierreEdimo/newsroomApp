import 'package:flutter/material.dart';
import 'package:newsroom/utilities/constants.dart';

Widget listTile(
  Icon icon,
  String title,
) {
  return Container(
    padding: verticalPadding,
    child: Row(
      children: [
        icon,
        horizontalSpace,
        Text(title),
      ],
    ),
  );
}
