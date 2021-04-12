import 'package:flutter/material.dart';
import 'package:newsroom/model/bookmark.dart';
import 'package:newsroom/service/bookmark_service.dart';
import 'package:newsroom/widget/bookmark_container.dart';
import 'package:provider/provider.dart';

Widget listOfBookMarks(
  context,
) {
  return FutureBuilder(
    future: Provider.of<BookMarkSerivce>(context).fetchBookMark(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<BookMark> bookmarks = snapshot.data;

        return bookmarks.length < 1
            ? Center(
                child: Text(" No Articles yet"),
              )
            : ListView(
                padding: EdgeInsets.only(
                  left: 25.0,
                  right: 25.0,
                  bottom: 10.0,
                ),
                children: bookmarks
                    .map(
                      (BookMark bookMark) => Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: bookMarkContainer(
                          bookMark,
                          context,
                        ),
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
