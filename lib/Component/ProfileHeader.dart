import 'package:flutter/material.dart';

import 'Custom.Title.dart';

Widget profileHeader(String title, IconButton settings, context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [listTitle(title, 22.0), settings],
    ),
  );
}
