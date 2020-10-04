import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:Newsroom/Service/ArticleService.dart';
import 'package:flutter/material.dart';

import 'ArticleDetail.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<List<Article>> articlesFound;
  ArticleService _articleService = ArticleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(30.0),
                  prefixIcon: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  hintText: "Search an Article",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                onChanged: (string) {
                  setState(() {
                    articlesFound =
                        _articleService.getArticlesForSearch(string);
                  });
                },
              ),
              Expanded(
                child: FutureBuilder(
                    future: articlesFound,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Article>> snapshot) {
                      if (snapshot.hasData) {
                        List<Article> articles = snapshot.data;

                        return ListView(
                            padding: EdgeInsets.all(10.0),
                            children: articles
                                .map(
                                  (Article article) => Container(
                                    child: ListTile(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ArticleDetail(
                                                      article: article,
                                                      favId: 0))),
                                      title: Text(article.title),
                                      trailing: Icon(Icons.arrow_right),
                                    ),
                                  ),
                                )
                                .toList());
                      }
                      return Center(
                        child: Text("Not Found"),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
