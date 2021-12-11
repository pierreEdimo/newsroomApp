import 'package:newsroom/model/article.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:flutter/material.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'article_container.dart';

Future<List<Article>> _fechtArticles(
  context,
  String url,
) async {
  return await Provider.of<ArticleService>(context, listen: false)
      .fetchArticles(url);
}

Widget listOfArticles(
  Future<List<Article>> articles,
  String url,
  String msg,
  context,
) {
  return FutureBuilder(
    future: articles,
    builder: (context, AsyncSnapshot<List<Article>> snapshot) {
      if (snapshot.hasError)
        return Center(
          child: Text(
            "Error , please try again later",
            textAlign: TextAlign.center,
          ),
        );
      if (snapshot.hasData) {
        List<Article> articles = snapshot.data!;
        return articles.length < 1
            ? Container(
                padding: horizontalPadding,
                child: Center(
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : RefreshIndicator(
                onRefresh: () => _fechtArticles(
                  context,
                  url,
                ),
                child: ListView(
                  padding: completePadding,
                  children: articles
                      .map(
                        (Article article) => Container(
                          child: articleContainer(
                            article,
                            context,
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
