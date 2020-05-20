import 'package:findadoctor/Model/ArticleModel.dart';
import 'package:findadoctor/Model/ThemeModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ArticleDetail.dart';

class ThemeArticleList extends StatelessWidget {
  final ThemeModel themeData;

  ThemeArticleList({Key key, @required this.themeData}) : super(key: key);

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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          themeData.name,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: themeData.articles.length,
          itemBuilder: (BuildContext context, int index) {
            Article article = themeData.articles[index];
            return Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 25),
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ArticleDetail(article: article))),
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
                                child: Image.network(article.imageUrl,
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              alignment: Alignment.centerLeft,
                              child: ListTile(
                                title: Text(
                                  article.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0),
                                ),
                                subtitle: Text("By ${article.author}"),
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
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
