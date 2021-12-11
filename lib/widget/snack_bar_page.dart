import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newsroom/model/add_bookmark.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/service/bookmark_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/display_diagog.dart';
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
  var box = Hive.box('newsBox');
  Icon stantdardIcon = Icon(
    Icons.bookmark_outline_outlined,
    color: Colors.black,
  );

  _SnackBarPageState({
    this.article,
  });

  @protected
  @mustCallSuper
  initState() {
    super.initState();
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

  standardIcon() {
    return stantdardIcon;
  }

  _refetchArticle() {
    ArticleService? articleService = ArticleService();
    articleService.fetchArticle(article!.id!).then((value) {
      setState(() {
        article = value;
      });
    });
  }

  bookMarkIcon() {
    String user = box.get('userId');
    for (int index = 0; index < article!.hasFavorites!.length; index++) {
      if (user == article!.hasFavorites![index].ownerId) {
        Icon icon = Icon(
          Icons.bookmark,
          color: Colors.black,
        );
        return icon;
      } else {
        return stantdardIcon;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return checkBookmark();
  }

  _addBookMark() async {
    String? uid = await storage.read(key: "userId");
    if(uid == null){
      showErrorDialog(context, "Error", unloggedTextError + "to add an Article in the bookmark");
    }
    AddBookMark bookMark = AddBookMark(
      ownerId: uid,
      articleId: article!.id!,
    );
    var statusCode = await Provider.of<BookMarkSerivce>(context, listen: false)
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
    print(statusCode);
    _refetchArticle();
  }

  checkBookmark() {
    return IconButton(
      icon: article!.hasFavorites!.length < 1 ? standardIcon() : bookMarkIcon(),
      onPressed: () {
        _addBookMark();
      },
    );
  }
}
