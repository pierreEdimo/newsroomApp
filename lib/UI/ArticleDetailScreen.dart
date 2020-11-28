import 'package:Newsroom/Component/Custom.Card.dart';
import 'package:Newsroom/Component/Custom.Title.dart';
import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:Newsroom/Service/ArticleService.dart';
import 'package:Newsroom/Service/AuthService.dart';
import 'package:Newsroom/UI/CommentPage.dart';
import 'package:flutter/material.dart';

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
                          height: 370,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(article.imageUrl),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          height: 370,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                          ),
                        ),
                        SafeArea(
                          child: Container(
                            height: 100,
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(10.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.keyboard_arrow_left,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(
                              bottom: 50.0, left: 20.0, right: 20.0),
                          height: 370,
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
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(article.author.imageUrl),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.author.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(article.createdAt,
                                          style: TextStyle(fontSize: 12.0))
                                    ],
                                  )
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
                            ),
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
                            SizedBox(
                              height: 20.0,
                            ),
                            listTitle('From the Same Author', 18.0),
                            SizedBox(height: 20.0),
                            Container(
                              child: FutureBuilder(
                                future: articlesFromAuthor,
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Article>> snapshot) {
                                  if (snapshot.hasData) {
                                    List<Article> articleFromAuthor =
                                        snapshot.data;

                                    return ListView(
                                      shrinkWrap: true,
                                      primary: false,
                                      padding: EdgeInsets.all(0.0),
                                      physics: ClampingScrollPhysics(),
                                      children: articleFromAuthor
                                          .map((Article article) => Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 20.0),
                                                child: InkWell(
                                                  onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ArticleDetailScreen(
                                                              articleId:
                                                                  article.id,
                                                              authorId: article
                                                                  .autorId,
                                                            )),
                                                  ),
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
                                          .toList(),
                                    );
                                  }

                                  return Text("");
                                },
                              ),
                            )
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
