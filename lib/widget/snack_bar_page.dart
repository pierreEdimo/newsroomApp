import 'package:flutter/material.dart';
import 'package:newsroom/model/add_bookmark.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/service/bookmark_service.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class SnackBarPage extends StatefulWidget {
  final Article? article;

  SnackBarPage({@required this.article});
  @override
  _SnackBarPageState createState() => _SnackBarPageState(article: article!);
}

class _SnackBarPageState extends State<SnackBarPage> {
  Article? article;
  String? userId;

  _SnackBarPageState({
    this.article,
  });

  @protected
  @mustCallSuper
  initState() {
    super.initState();
    _setUserId();
  }

  void _setUserId() async {
    userId = await storage.read(key: "userId");
  }

  showSnack(
    String message,
    BuildContext context,
  ) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 1),
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.bookmark_outline_outlined,
        color: Colors.black,
      ),
      onPressed: () async {
        String? uid = await storage.read(key: "userId");
        AddBookMark bookMark = AddBookMark(
          ownerId: uid,
          articleId: article!.id!,
        );
        var statusCode =
            await Provider.of<BookMarkSerivce>(context, listen: false)
                .addBookMark(bookMark);
        if (statusCode == 201) {
          showSnack("article has been added", context);
        } else {
          await Provider.of<BookMarkSerivce>(context, listen: false)
              .deleteFavorite(article!.id!)
              .then(
                (_) => showSnack(
                  "article has been removed",
                  context,
                ),
              );
        }
      },
    );
  }
}
