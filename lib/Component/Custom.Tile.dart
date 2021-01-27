import 'package:flutter/material.dart';

Widget customTile(Icon leadingIcon, String title, Icon trailingIcon) {
  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.grey.shade100,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            leadingIcon,
            SizedBox(
              width: 20.0,
            ),
            Text(title)
          ],
        ),
        trailingIcon
      ],
    ),
  );
}
