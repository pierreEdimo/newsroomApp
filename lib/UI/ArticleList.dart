import 'package:findadoctor/Model/ArticleModel.dart';
import 'package:findadoctor/Service/ArticleService.dart';
import 'package:findadoctor/UI/ArticleDetail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListArticlePage extends StatelessWidget {
  final ArticleService articleService = new ArticleService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('image/icon.png'),
        title: Text(
          "Newsfeed",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () => print("Hello World"),
          )
        ],
      ),
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
                        .map((Article article) => Container(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(bottom: 25),
                                      child: InkWell(
                                        onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ArticleDetail(
                                                      article: article,
                                                    ))),
                                        child: Card(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Container(
                                                width: 700,
                                                height: 250,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  5.0)),
                                                  child: Image.network(
                                                    article.imageUrl,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ListTile(
                                                    title: Text(
                                                      article.title,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 22.0),
                                                    ),
                                                    subtitle: Text(
                                                        "By ${article.author}"),
                                                  )),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  bottom: 5.0,
                                                  left: 20.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text("vor 8 stunden"),
                                                    IconButton(
                                                      icon: FaIcon(
                                                        FontAwesomeIcons
                                                            .bookmark,
                                                        size: 18,
                                                      ),
                                                      onPressed: () =>
                                                          print("Hello World"),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ))
                        .toList());
              }
              return Center(
                child: Text(""),
              );
            }),
      ),
    );
  }
}
