import 'package:findadoctor/Model/ArticleModel.dart';
import 'package:findadoctor/Service/ArticleService.dart';
import 'package:findadoctor/UI/ArticleDetail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'SearchPage.dart';

class ListArticlePage extends StatelessWidget {
  final ArticleService articleService = new ArticleService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "HealthAdvice",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: FutureBuilder(
            future: articleService.getArticles(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
              if (snapshot.hasData) {
                List<Article> articles = snapshot.data;

                return ListView(
                    padding: EdgeInsets.all(20),
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
                                                height: 200,
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
                                                  ))
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
                child: CircularProgressIndicator(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchPage()));
          },
          child: FaIcon(
            FontAwesomeIcons.search,
            size: 18,
          ),
          backgroundColor: Colors.blue),
    );
  }
}
