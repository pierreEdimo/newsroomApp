import 'package:flutter/material.dart';
import 'package:newsroom/screens/bookmark_screen.dart';
import 'package:newsroom/widget/list_tile.dart';

Widget bookMarkTile(context) {
  return InkWell(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookMarkScreen(),
      ),
    ),
    child: listTile(
      Icon(Icons.bookmark_outline, size: 25,),
      "Bookmarks",
    ),
  );
}
