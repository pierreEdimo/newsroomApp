import 'package:flutter/material.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:newsroom/widget/list_of_articles.dart';
import 'package:newsroom/widget/title_row.dart';
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
      appBar: customAppBar(
        titleRow(
          topicName!,
          IconButton(
            icon: Icon(Icons.close_outlined),
            onPressed: () => Navigator.of(context).pop(),
          ),
          context,
        ),
        80.0,
      ),
      body: listOfArticles(
        Provider.of<ArticleService>(context).fetchArticles(
            "https://newsplace.azurewebsites.net/api/articles/Filter?TopicId=$topicId"),
        "https://newsplace.azurewebsites.net/api/articles/Filter?TopicId=$topicId",
        "No Articles",
        context,
      ),
    );
  }
}
