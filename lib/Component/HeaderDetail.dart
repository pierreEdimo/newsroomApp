import 'package:flutter/material.dart';

import 'Custom.Title.dart';

Widget headerDetail(String title, context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        listTitle(title, 22.0),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    ),
  );
}
