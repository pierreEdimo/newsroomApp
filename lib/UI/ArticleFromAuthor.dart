import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:Newsroom/Service/ArticleService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ArticleDetail.dart';

class ArticleFromAuthor extends StatefulWidget {
  final Article article;

  ArticleFromAuthor({Key key, @required this.article}) : super(key: key);

  @override
  _ArticleFromAuthorState createState() =>
      _ArticleFromAuthorState(article: article);
}

class _ArticleFromAuthorState extends State<ArticleFromAuthor> {
  Article article;
  List<Article> articles = List();
  List<Article> articlesFromAuthor = List();
  ArticleService _articleService = ArticleService();

  _ArticleFromAuthorState({@required this.article});
  @override
  void initState() {
    super.initState();
    _articleService.getArticles().then((value) {
      setState(() {
        articles = value;
        articlesFromAuthor = articles
            .where((element) => (element.author.id) == article.author.id)
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            size: 18,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: CircleAvatar(
          backgroundImage: NetworkImage(article.author.imageUrl),
        ),
      ),
      body: ListView.builder(
        itemCount: articlesFromAuthor.length,
        padding: EdgeInsets.all(10.0),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ArticleDetail(
                          article: articlesFromAuthor[index],
                          favId: 0,
                        ))),
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 20.0),
                        alignment: Alignment.center,
                        width: 500,
                        height: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    articlesFromAuthor[index].imageUrl),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20.0),
                        alignment: Alignment.center,
                        width: 500,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20.0),
                        alignment: Alignment.bottomLeft,
                        width: 500,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ListTile(
                          title: Text(
                            articlesFromAuthor[index].title,
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            "By ${articlesFromAuthor[index].author.name} ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
