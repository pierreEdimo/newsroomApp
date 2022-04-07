import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/list_of_articles.dart';
import 'package:newsroom/widget/search_icon.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class BookMarkScreen extends StatelessWidget {
  final String? uid = box.get("userId");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Bookmark',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [searchIcon(context)],
      ),
      body: Center(
          child: uid == null
              ? Center(
                  child: Text(
                    unLoggedTextError + " to read the Bookmark",
                    textAlign: TextAlign.center,
                  ),
                )
              : FutureBuilder(
                  future: Provider.of<ArticleService>(context).fetchArticles(
                      "https://newsplace.azurewebsites.net/api/articles/Filter?UserId=$uid"),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Article>> snapshot) {
                    if (snapshot.hasError)
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    if (snapshot.hasData) {
                      List<Article> articles = snapshot.data!;
                      return ListOfArticles(
                        articles: articles,
                        msg: "No Articles",
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )),
    );
  }
}
