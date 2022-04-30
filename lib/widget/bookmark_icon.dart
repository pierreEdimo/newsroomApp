import 'package:flutter/material.dart';
import 'package:newsroom/model/add_bookmark.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'display_dialog.dart';

class BookMarkIcon extends StatefulWidget {
  final Article? inheritedArticle;
  const BookMarkIcon({Key? key, this.inheritedArticle}) : super(key: key);

  @override
  _BookMarkIconState createState() => _BookMarkIconState();
}

class _BookMarkIconState extends State<BookMarkIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => bookMark(widget.inheritedArticle!, context),
      icon: widget.inheritedArticle!.isFavorite! == true
          ? Icon(
              Icons.bookmark,
              color: Colors.red,
            )
          : Icon(
              Icons.bookmark_outline_outlined,
            ),
    );
  }

  void bookMark(Article article, context) async {
    var userId = await storage.read(key: "userId");
    //bool? oldStatus;

    if (userId == null)
      showErrorDialog(
          context, "Error", unLoggedTextError + " to Bookmark an Article.");

    AddBookMark newBookMark = AddBookMark(
      articleId: article.id!,
      ownerId: userId,
    );

    Provider.of<ArticleService>(context, listen: false)
        .addBookMark(article, newBookMark);
  }
}
