import 'package:Newsroom/Component/Custom.Card.dart';
import 'package:Newsroom/Component/Custom.Title.dart';
import 'package:Newsroom/Component/Theme.Card.dart';
import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:Newsroom/Model/ThemeModel.dart';

import 'package:Newsroom/Service/ArticleService.dart';

import 'package:Newsroom/Service/ThemeService.dart';
import 'package:Newsroom/UI/ArticleDetailScreen.dart';

import 'package:Newsroom/UI/ThemeDetailScreen.dart';

import 'package:flutter/material.dart';

class ArticleSreen extends StatefulWidget {
  @override
  _ArticleSreenState createState() => _ArticleSreenState();
}

class _ArticleSreenState extends State<ArticleSreen> {
  Future<List<Article>> _articles;
  final ArticleService _articleService = ArticleService();

  Future<List<ThemeModel>> _themes;
  final ThemeService _themeService = ThemeService();

  @override
  void initState() {
    super.initState();
    _fetchArticles();
    _fetchThemes();
  }

  _fetchArticles() {
    _articles = _articleService.getArticles();
  }

  _fetchThemes() {
    _themes = _themeService.getAllThemes();
  }

  /*+Future<void> _getArticles() async {
    setState(() {
      _fetchArticles();
    });
  }**/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(
              child: Container(
                height: 60,
                child: listTitle("hot Topics", 22.0),
              ),
            ),
            Container(
              height: 200,
              child: FutureBuilder(
                future: _themes,
                builder: (BuildContext context,
                    AsyncSnapshot<List<ThemeModel>> snapshot) {
                  if (snapshot.hasData) {
                    List<ThemeModel> themes = snapshot.data;

                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: themes
                          .map((ThemeModel theme) => InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ThemeDetailScreen(themeId: theme.id),
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(right: 20.0),
                                  child: themeCard(
                                    theme.name,
                                    theme.imageUrl,
                                    150,
                                    16.0,
                                    200,
                                  ),
                                ),
                              ))
                          .toList(),
                    );
                  }
                  return Center(
                    child: Text(""),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            listTitle('Latest News', 18.0),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: FutureBuilder(
                future: _articles,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Article>> snapshot) {
                  if (snapshot.hasData) {
                    List<Article> articles = snapshot.data;

                    return ListView(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.all(0.0),
                      physics: ClampingScrollPhysics(),
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
                                    20.0,
                                    250,
                                    article.author.imageUrl,
                                    article.author.name,
                                    article.createdAt),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
