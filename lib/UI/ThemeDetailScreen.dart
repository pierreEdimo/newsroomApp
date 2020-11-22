import 'package:Newsroom/Component/Custom.Card.dart';
import 'package:Newsroom/Component/Custom.Title.dart';
import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:Newsroom/Model/ThemeModel.dart';
import 'package:Newsroom/Service/ThemeService.dart';
import 'package:Newsroom/UI/ArticleDetailScreen.dart';
import 'package:flutter/material.dart';

class ThemeDetailScreen extends StatefulWidget {
  final int themeId;

  ThemeDetailScreen({@required this.themeId});
  @override
  _ThemeDetailScreenState createState() =>
      _ThemeDetailScreenState(themeId: themeId);
}

class _ThemeDetailScreenState extends State<ThemeDetailScreen> {
  ThemeService _themeService = ThemeService();
  Future<ThemeModel> themeModel;
  int themeId;

  _ThemeDetailScreenState({@required this.themeId});

  @override
  void initState() {
    super.initState();
    _fetchSingleTheme();
  }

  _fetchSingleTheme() {
    themeModel = _themeService.getAThemebyId(themeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Container(
            child: FutureBuilder(
              future: themeModel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  ThemeModel themeModel = snapshot.data;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SafeArea(
                        child: Container(
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              listTitle(themeModel.name, 22.0),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => Navigator.of(context).pop(),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child: ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
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
                                            20.0,
                                            250,
                                            article.author.imageUrl,
                                            article.author.name,
                                            article.createdAt),
                                      ),
                                    ))
                                .toList()),
                      )
                    ],
                  );
                }
                return Text("");
              },
            ),
          )),
    );
  }
}
