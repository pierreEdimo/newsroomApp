import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/article.dart';
import '../service/article_service.dart';
import 'list_of_articles.dart';

class HomeArticleContainer extends StatelessWidget {
  final String? url;
  final bool? shrinkWrap;
  final Widget? child;

  const HomeArticleContainer({
    Key? key,
    this.url,
    this.shrinkWrap,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ArticleService>(context, listen: true)
          .fetchArticles(url!),
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text(snapshot.error.toString()),
          );
        if (snapshot.hasData) {
          List<Article> articles = snapshot.data!;
          return ListOfArticles(
            child: child,
            articles: articles,
            shrinkwrap: shrinkWrap,
            msg: "No Articles",
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
