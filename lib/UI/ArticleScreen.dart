import 'package:Newsroom/Component/Center.Error.dart';
import 'package:Newsroom/Component/Custom.Card.dart';

import 'package:Newsroom/Component/Header.dart';

import 'package:Newsroom/Model/ArticleModel.dart';

import 'package:Newsroom/Service/ArticleService.dart';

import 'package:Newsroom/UI/ArticleDetailScreen.dart';

import 'package:flutter/material.dart';

class ArticleSreen extends StatefulWidget {
  @override
  _ArticleSreenState createState() => _ArticleSreenState();
}

class _ArticleSreenState extends State<ArticleSreen> {
  Future<List<Article>> _articles;
  final ArticleService _articleService = ArticleService();

  String _url =
      "https://findadoc.azurewebsites.net/api/Article?sortBy=title&sortOrder=desc&Size=20";

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  _fetchArticles() {
    _articles = _articleService.getArticles(_url);
  }

  Future<void> _loadArticles() async {
    setState(() {
      _fetchArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(
              child: header("Latest News", context),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Container(
                child: RefreshIndicator(
                  onRefresh: _loadArticles,
                  child: FutureBuilder(
                    future: _articles,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Article>> snapshot) {
                      if (snapshot.hasData) {
                        List<Article> articles = snapshot.data;

                        return ListView(
                          padding: EdgeInsets.all(0.0),
                          children: articles
                              .map(
                                (Article article) => InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ArticleDetailScreen(
                                        articleId: article.id,
                                        authorId: article.autorId,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 20.0),
                                    child: customCard(
                                        article.title,
                                        article.imageUrl,
                                        400,
                                        18.0,
                                        250,
                                        article.author.name,
                                        article.createdAt),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      } else if (snapshot.hasError) {
                        return centerError();
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
