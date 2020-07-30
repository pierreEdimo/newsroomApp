import 'package:Newsroom/Model/ArticleModel.dart';

import 'package:Newsroom/Service/ArticleService.dart';
import 'package:Newsroom/UI/ArticleDetail.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Image.asset('image/icon.png'),
        centerTitle: true,
        title: Text("Newsfeed",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans')),
        actions: <Widget>[
          IconButton(
            icon:
                FaIcon(FontAwesomeIcons.search, color: Colors.black, size: 18),
            onPressed: () {},
          )
        ],
      ),
      body: ArticleList(),
    );
  }
}

class ArticleList extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleList> {
  final ArticleService articleService = ArticleService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: articleService.getArticles(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
              if (snapshot.hasData) {
                List<Article> articles = snapshot.data;

                return ListView(
                    padding: EdgeInsets.all(10),
                    children: articles
                        .map(
                          (Article article) => Container(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: InkWell(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => ArticleDetail(
                                              article: article,
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
                                                    article.imageUrl),
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
                                            article.title,
                                            style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          subtitle: Text(
                                            "By ${article.author.name} ",
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
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.exclamationTriangle,
                        size: 80,
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Text(
                          "Error your phone is not connected to the internet, please try again later",
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                );
              }

              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
