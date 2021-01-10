import 'package:Newsroom/Component/Custom.Card.dart';
import 'package:Newsroom/Component/Header.dart';
import 'package:Newsroom/Model/FavoriteArticleModel.dart';
import 'package:Newsroom/Service/ArticleService.dart';
import 'package:Newsroom/UI/ArticleDetailScreen.dart';
import 'package:Newsroom/main.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final ArticleService _articleService = ArticleService();
  Future<List<FavoriteModel>> _articles;

  Future<List<FavoriteModel>> _fetchFavs() async {
    var userId = await storage.read(key: "userId");
    return _articleService.getFavArticles(userId);
  }

  @override
  void initState() {
    super.initState();
    _articles = _fetchFavs();
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
              child: header("My Favorites", context),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              flex: 1,
              child: Container(
                  child: FutureBuilder(
                future: _articles,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<FavoriteModel> articles = snapshot.data;

                    return articles.length < 1
                        ? Center(
                            child: Text("there are no articles bookmarked yet"))
                        : ListView(
                            padding: EdgeInsets.all(0.0),
                            children: articles
                                .map(
                                  (FavoriteModel article) => InkWell(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ArticleDetailScreen(
                                                articleId: article.articleId,
                                                authorId:
                                                    article.article.autorId),
                                      ),
                                    ),
                                    child: customCard(
                                        article.article.title,
                                        article.article.imageUrl,
                                        400,
                                        20.0,
                                        250.0,
                                        article.article.author.imageUrl,
                                        article.article.author.name,
                                        article.article.createdAt),
                                  ),
                                )
                                .toList(),
                          );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )),
            )
          ],
        ),
      ),
    );
  }
}
