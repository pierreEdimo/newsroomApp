import 'package:Newsroom/Component/Custom.Card.dart';
import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:Newsroom/main.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:Newsroom/Service/ArticleService.dart';
import 'package:Newsroom/Service/AuthService.dart';
import 'package:Newsroom/UI/CommentPage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailScreen extends StatefulWidget {
  final int articleId;
  final int authorId;

  ArticleDetailScreen({@required this.articleId, @required this.authorId});
  @override
  _ArticleDetailScreenState createState() =>
      _ArticleDetailScreenState(articleId: articleId, authorId: authorId);
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  int articleId;

  int authorId;
  Future<List<Article>> articlesFromAuthor;

  _ArticleDetailScreenState(
      {@required this.articleId, @required this.authorId});

  AuthService _authService = AuthService();
  ArticleService _articleService = ArticleService();
  Future<Article> article;
  bool isAdded;

  @override
  void initState() {
    super.initState();
    _authService.fethSingleUser();
    _fetchArticle();
    _fetchArticleFromAuthor();
  }

  _fetchArticle() {
    article = _articleService.fetchArticle(articleId);
  }

  _fetchArticleFromAuthor() {
    articlesFromAuthor = _articleService.getArticleFromAuthor(authorId);
  }

  Future<void> refetch() async {
    setState(() {
      _fetchArticle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: article,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Article article = snapshot.data;

              return Container(
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 350,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(article.imageUrl),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          height: 350,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                          ),
                        ),
                        SafeArea(
                          child: Container(
                            height: 100,
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                SnackBarPage(
                                  articleId: articleId,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(
                              bottom: 50.0, left: 20.0, right: 20.0),
                          height: 350,
                          child: Text(
                            article.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                                fontSize: 22.0),
                          ),
                        )
                      ],
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  text('By ${article.author.name}. ', 12.0,
                                      Colors.black),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  text('Added on ${article.createdAt} ', 12.0,
                                      Colors.black),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Markdown(
                                data: article.content,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                padding: EdgeInsets.all(0.0),
                                onTapLink: (url, href, title) {
                                  launch(href);
                                }),
                            SizedBox(
                              height: 20.0,
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CommentPage(articleId: article.id),
                                ),
                              ).then((_) => refetch()),
                              child: Container(
                                width: 500,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.red),
                                child: Center(
                                  child: Text(
                                    "(${article.numberOfComments.toString()})  Comments ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  final ArticleService _articleService = ArticleService();
  final int articleId;

  SnackBarPage({@required this.articleId});

  showSnack(String message, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(message),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.bookmark_border_outlined,
        color: Colors.white,
      ),
      onPressed: () async {
        var userId = await storage.read(key: 'userId');

        var result = await _articleService.addToFavorites(userId, articleId);
        if (result == 201) {
          showSnack("article has been added", context);
        } else {
          _articleService
              .deleteFavorite(articleId)
              .then((_) => showSnack("article has been removed", context));
        }
      },
    );
  }
}
