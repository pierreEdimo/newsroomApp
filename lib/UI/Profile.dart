import 'package:Newsroom/Component/Center.Error.dart';
import 'package:Newsroom/Component/Custom.Card.dart';

import 'package:Newsroom/Component/Custom.Title.dart';
import 'package:Newsroom/Model/FavoriteArticleModel.dart';
import 'package:Newsroom/Model/UserModel.dart';
import 'package:Newsroom/Service/ArticleService.dart';
import 'package:Newsroom/Service/AuthService.dart';
import 'package:Newsroom/UI/About.dart';

import 'package:Newsroom/UI/Login.dart';
import 'package:Newsroom/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ArticleDetailScreen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService _authService = AuthService();
  Future<UserModel> user;

  @override
  void initState() {
    super.initState();
    _fetchUser();
    _articles = _fetchFavs();
  }

  _fetchUser() {
    user = _authService.fethSingleUser();
  }

  _sendEmail() async {
    const url = 'mailto:pierredimo@live.com?subject=&body=%20';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
    Navigator.of(context).pop();
  }

  final ArticleService _articleService = ArticleService();
  Future<List<FavoriteModel>> _articles;

  Future<List<FavoriteModel>> _fetchFavs() async {
    var userId = await storage.read(key: "userId");
    return _articleService.getFavArticles(userId);
  }

  Future<void> _loadFavs() async {
    setState(() {
      _articles = _fetchFavs();
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
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    listTitle("Profile", 22.0),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () => _showModalSheet(),
                    ),
                  ],
                ),
              ),
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
                                    onTap: () => Navigator.of(context)
                                        .push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ArticleDetailScreen(
                                                    articleId:
                                                        article.articleId,
                                                    authorId: article
                                                        .article.autorId),
                                          ),
                                        )
                                        .then(
                                          (_) => _loadFavs(),
                                        ),
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 20.0),
                                      child: customCard(
                                          article.article.title,
                                          article.article.imageUrl,
                                          400,
                                          18.0,
                                          250.0,
                                          article.article.author.name,
                                          article.article.createdAt),
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
              )),
            )
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    storage.delete(key: "jwt");
    storage.delete(key: "userId");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Auth()),
        (Route<dynamic> route) => false);
  }

  void _showModalSheet() async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Container(
                height: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.edit_outlined,
                        color: Colors.blue.shade400,
                      ),
                      title: Text("edit Profile"),
                    ),
                    ListTile(
                      onTap: () => _sendEmail(),
                      leading: Icon(
                        Icons.email_outlined,
                        color: Colors.blue.shade400,
                      ),
                      title: Text("Contact us"),
                    ),
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) => AboutScreen(),
                            ),
                          )
                          .then((_) => Navigator.of(context).pop()),
                      leading: Icon(
                        Icons.info_outlined,
                        color: Colors.green.shade400,
                      ),
                      title: Text("About !"),
                    ),
                    ListTile(
                      onTap: () => _logout(context),
                      leading: Icon(
                        Icons.logout,
                        color: Colors.red.shade400,
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
