import 'package:findadoctor/Model/ArticleModel.dart';
import 'package:findadoctor/Service/ArticleService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ArticleDetailFromAuthor.dart';

class ArticleFromAuthor extends StatefulWidget {
  final Article article;

  ArticleFromAuthor({Key key, @required this.article}) : super(key: key);

  @override
  _ArticleFromAuthorState createState() =>
      _ArticleFromAuthorState(article: article);
}

class _ArticleFromAuthorState extends State<ArticleFromAuthor> {
  final Article article;
  List<Article> articles = List();
  List<Article> articlesFromAuthors = List();
  final ArticleService articleService = new ArticleService();

  _ArticleFromAuthorState({@required this.article});

  @override
  void initState() {
    super.initState();
    articleService.getArticles().then((articleFromServers) {
      setState(() {
        articles = articleFromServers;
        articlesFromAuthors =
            articles.where((u) => (u.author.contains(article.author))).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            size: 18,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                  image: NetworkImage(article.authorImg), fit: BoxFit.cover)),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: articlesFromAuthors.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 25),
                  child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ArticleDetailFromAuthor(
                                article: articlesFromAuthors[index],
                              ))),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              width: 700,
                              height: 250,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0)),
                                child: Image.network(
                                    articlesFromAuthors[index].imageUrl,
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 18.0),
                              alignment: Alignment.centerLeft,
                              child: ListTile(
                                title: Text(
                                  article.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0),
                                ),
                                subtitle: Text(
                                    "By ${articlesFromAuthors[index].author}"),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 5.0, left: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("vor 8 stunden"),
                                  IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.bookmark,
                                      size: 18,
                                    ),
                                    onPressed: () => print("Hello World"),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ));
          },
        ),
      ),
    );
  }
}
