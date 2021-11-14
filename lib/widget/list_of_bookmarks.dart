import 'package:flutter/material.dart';
import 'package:newsroom/model/bookmark.dart';
import 'package:newsroom/service/bookmark_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/bookmark_container.dart';
import 'package:provider/provider.dart';

Widget listOfBookMarks(
  context,
) {
  return FutureBuilder(
    future: Provider.of<BookMarkSerivce>(context).fetchBookMark(),
    builder: (context, AsyncSnapshot<List<BookMark>> snapshot) {
      if (snapshot.hasData) {
        List<BookMark> bookmarks = snapshot.data!;

        return bookmarks.length < 1
            ? Center(
                child: Text(" No Articles yet"),
              )
            : ListView(
                padding: completePadding,
                children: bookmarks
                    .map(
                      (BookMark bookMark) => bookMarkContainer(
                        bookMark,
                        context,
                      ),
                    )
                    .toList(),
              );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
