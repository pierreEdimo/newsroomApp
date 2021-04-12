import 'package:flutter/material.dart';
import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:newsroom/widget/list_of_bookmarks.dart';
import 'package:newsroom/widget/title_row.dart';

class BookMarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 100,
        child: titleRow(
            "Bookmark",
            IconButton(
              icon: Icon(Icons.close_outlined),
              onPressed: () => Navigator.of(context).pop(),
            ),
            context),
      ),
      body: listOfBookMarks(context),
    );
  }
}
