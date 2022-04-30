import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/widget/close_icon.dart';
import 'package:newsroom/widget/list_of_articles.dart';
import 'package:provider/provider.dart';

class ArticleFromTopic extends StatelessWidget {
  final int? topicId;
  final String? topicName;

  ArticleFromTopic({
    @required this.topicId,
    @required this.topicName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '$topicName',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [closeIcon(context)],
      ),
      body: FutureBuilder(
        future: Provider.of<ArticleService>(context).fetchArticles(
            "https://newsplace.azurewebsites.net/api/articles/Filter?TopicId=$topicId"),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text(snapshot.error.toString()),
            );
          if (snapshot.hasData) {
            List<Article> articles = snapshot.data!;
            return ListOfArticles(
              shrinkwrap: true,
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
