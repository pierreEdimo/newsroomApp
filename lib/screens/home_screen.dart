import 'package:newsroom/model/article.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/widget/list_of_articles.dart';
import 'package:flutter/material.dart';
import 'package:newsroom/widget/search_icon.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final String url = "https://newsplace.azurewebsites.net/api/Articles";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Newsroom",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [searchIcon(context)],
      ),
      body: FutureBuilder(
        future: Provider.of<ArticleService>(context, listen: true)
            .fetchArticles(url),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
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
      ),
    );
  }
}
