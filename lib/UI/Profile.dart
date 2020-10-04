import 'package:Newsroom/Model/FavoritesArticle.dart';

import 'package:Newsroom/Service/ArticleService.dart';
import 'package:Newsroom/Service/AuthService.dart';
import 'package:Newsroom/UI/ArticleDetail.dart';
import 'package:Newsroom/UI/Login.dart';
import 'package:Newsroom/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.fethSingleUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Favorites",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.cog,
              color: Colors.black,
              size: 18,
            ),
            onPressed: () => _showModalSheet(),
          )
        ],
        elevation: 0,
        leading: Image.asset('image/icon.png'),
      ),
      body: FavoritesArticleList(),
    );
  }

  void logout(BuildContext context) async {
    storage.delete(key: "jwt");
    storage.delete(key: "userId");
    Navigator.push(context, MaterialPageRoute(builder: (context) => Auth()));
  }

  void _showModalSheet() async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 130,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.pen,
                      color: Colors.black,
                      size: 18,
                    ),
                    title: Text('Edit Profil',
                        style: TextStyle(color: Colors.black)),
                  ),
                  ListTile(
                    onTap: () => logout(context),
                    leading: FaIcon(
                      FontAwesomeIcons.signOutAlt,
                      color: Colors.black,
                      size: 18,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class FavoritesArticleList extends StatefulWidget {
  @override
  _FavoritesArticleListState createState() => _FavoritesArticleListState();
}

class _FavoritesArticleListState extends State<FavoritesArticleList> {
  final ArticleService _articleService = ArticleService();
  List<GetFavoriteArticleModel> articles = List();
  Future<String> user;

  @override
  initState() {
    super.initState();
    _fetchFavoritesArticles();
  }

  void _fetchFavoritesArticles() async {
    var userId = await storage.read(key: "userId");
    _articleService.getFovites(userId).then((value) {
      setState(() {
        articles = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return articles.isEmpty
        ? Center(child: Text("No Bookmark"))
        : Builder(
            builder: (BuildContext context) {
              if (articles.isNotEmpty) {
                return ListView(
                    padding: EdgeInsets.all(10.0),
                    children: articles
                        .map(
                          (GetFavoriteArticleModel article) => Container(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: InkWell(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => ArticleDetail(
                                              article: article.article,
                                              favId: article.id,
                                            ))),
                                child: Center(
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(bottom: 20.0),
                                        alignment: Alignment.center,
                                        width: 500,
                                        height: 230,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    article.article.imageUrl),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(bottom: 20.0),
                                        alignment: Alignment.center,
                                        width: 500,
                                        height: 230,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Color.fromRGBO(0, 0, 0, 0.2),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(bottom: 20.0),
                                        alignment: Alignment.bottomLeft,
                                        width: 500,
                                        height: 230,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            article.article.title,
                                            style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          subtitle: Text(
                                            "By ${article.article.author.name} ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList());
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
  }
}
