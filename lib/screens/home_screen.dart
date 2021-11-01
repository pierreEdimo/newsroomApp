import 'package:newsroom/screens/search_screen.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:newsroom/widget/list_of_articles.dart';
import 'package:flutter/material.dart';
import 'package:newsroom/widget/title_row.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final String url = "https://newsplace.azurewebsites.net/api/Articles/Filter";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          titleRow(
              "Home",
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                ),
              ),
              context),
          80.0),
      body: listOfArticles(
        Provider.of<ArticleService>(context).fetchArticles(url),
        url,
        "No Articles",
        context,
      ),
    );
  }
}
