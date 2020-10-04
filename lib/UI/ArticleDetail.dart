import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:Newsroom/Model/FavoritesArticle.dart';
import 'package:Newsroom/Service/ArticleService.dart';
import 'package:Newsroom/Service/AuthService.dart';
import 'package:Newsroom/UI/CommentPage.dart';
import 'package:Newsroom/main.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ArticleFromAuthor.dart';

class ArticleDetail extends StatefulWidget {
  final Article article;
  final int favId;

  ArticleDetail({@required this.article, @required this.favId});
  @override
  _ArticleDetailState createState() => _ArticleDetailState(
        article: article,
        favId: favId,
      );
}

class _ArticleDetailState extends State<ArticleDetail> {
  Article article;
  int favId;
  bool isAdded = false;
  final ArticleService _articleService = ArticleService();
  final AuthService _authService = AuthService();

  _ArticleDetailState({
    @required this.article,
    @required this.favId,
  });

  @override
  void initState() {
    super.initState();
    _authService.fethSingleUser();
    print(favId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(article.imageUrl),
                        fit: BoxFit.cover)),
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                ),
              ),
              Container(
                height: 100,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.bookmark,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () async {
                        var userId = await storage.read(key: "userId");
                        AddFavoriteArticleModel articleModel =
                            AddFavoriteArticleModel(
                                articleId: article.id, userId: userId);
                        int res =
                            await _articleService.addFavorite(articleModel);

                        if (res == 201) {
                          displayDialog(context, "Success",
                              "this article has been added to your favorites");
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -20.0, 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  title: Text(
                    article.title,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 17),
                  alignment: Alignment.topLeft,
                  child: Text("Am 06-07-20", style: TextStyle(fontSize: 12)),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 17, right: 17),
                  child: Text(
                    article.content,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ArticleFromAuthor(article: article))),
                  child: Container(
                    color: Color.fromRGBO(230, 230, 230, 0.2),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              article.author.imageUrl),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                article.author.name,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 360,
                            child: Text(
                              "${article.author.biography}",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            CommentPage(articleId: article.id))),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.red.shade600),
                      padding: EdgeInsets.all(15.0),
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.commentAlt, size: 18),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text("Comment")
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
