import 'package:Newsroom/Component/Custom.Card.dart';
import 'package:Newsroom/Component/Custom.Title.dart';
import 'package:Newsroom/Model/Favorite.dart';
import 'package:Newsroom/Service/ArticleService.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Favorite> favorites = List();
  ArticleService _articleService = ArticleService();

  @override
  void initState() {
    super.initState();
    _fecthFavorites();
  }

  void _fecthFavorites() async {
    var userId = await storage.read(key: "userId");
    _articleService.getFavorites(userId).then((value) {
      setState(() {
        favorites = value;
      });
    });
  }

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
                height: 60.0,
                child: listTitle("Bookmark", 22.0),
              ),
            ),
            Container(
                child: favorites.isEmpty
                    ? Container(
                        height: 500,
                        child: Center(
                          child: Text("No BookMark"),
                        ),
                      )
                    : Builder(
                        builder: (context) {
                          return ListView(
                            shrinkWrap: true,
                            primary: false,
                            physics: ClampingScrollPhysics(),
                            padding: EdgeInsets.all(0.0),
                            children: favorites
                                .map(
                                  (Favorite favorite) => Container(
                                    margin: EdgeInsets.only(bottom: 20.0),
                                    child: InkWell(
                                      child: customCard(
                                          favorite.article.title,
                                          favorite.article.imageUrl,
                                          400,
                                          20.0,
                                          200,
                                          favorite.article.author.imageUrl,
                                          favorite.article.author.name,
                                          "06.11.2020"),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ))
          ],
        ),
      ),
    );
  }
}
