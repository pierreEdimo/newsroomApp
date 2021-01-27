import 'package:Newsroom/Component/Custom.Card.dart';
import 'package:Newsroom/Component/EmptyArray.dart';
import 'package:Newsroom/Component/HeaderDetail.dart';
import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:Newsroom/Model/ThemeModel.dart';
import 'package:Newsroom/Service/ThemeService.dart';
import 'package:Newsroom/UI/ArticleDetailScreen.dart';
import 'package:flutter/material.dart';

class ThemeDetailScreen extends StatefulWidget {
  final int themeId;
  final String themeName;

  ThemeDetailScreen({@required this.themeId, @required this.themeName});
  @override
  _ThemeDetailScreenState createState() =>
      _ThemeDetailScreenState(themeId: themeId, themeName: themeName);
}

class _ThemeDetailScreenState extends State<ThemeDetailScreen> {
  ThemeService _themeService = ThemeService();
  Future<ThemeModel> _themeModel;
  int themeId;
  String themeName;

  _ThemeDetailScreenState({@required this.themeId, @required this.themeName});

  @override
  void initState() {
    super.initState();
    _themeModel = _themeService.getAThemebyId(themeId);
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
              child: headerDetail(themeName, context),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Container(
                child: FutureBuilder(
                  future: _themeModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      ThemeModel themeModel = snapshot.data;

                      return themeModel.articles.length < 1
                          ? Center(
                              child: emptyArray(
                                  "there are no Articles on this topic yet , please try again later",
                                  context),
                            )
                          : ListView(
                              padding: EdgeInsets.all(0.0),
                              children: themeModel.articles
                                  .map((Article article) => InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ArticleDetailScreen(
                                                        articleId: article.id,
                                                        authorId:
                                                            article.autorId))),
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
                                      ))
                                  .toList());
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
