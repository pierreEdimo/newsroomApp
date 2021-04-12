import 'package:flutter/material.dart';
import 'package:newsroom/screens/about_screen.dart';
import 'package:newsroom/widget/list_tile.dart';

Widget aboutTile(context) {
  return InkWell(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AboutScreen(),
      ),
    ),
    child: listTile(
      Icon(Icons.info_outline),
      "About",
    ),
  );
}
