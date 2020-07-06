import 'package:findadoctor/Model/ArticleModel.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArticleDetail extends StatelessWidget {
  final Article article;

  ArticleDetail({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:
              FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.black, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          article.title,
          style: TextStyle(color: Colors.black, fontFamily: 'OpenSans'),
        ),
        actions: <Widget>[
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.bookmark,
              color: Colors.black,
              size: 18,
            ),
            onPressed: () => print("Hello World"),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(article.imageUrl),
                      fit: BoxFit.cover))),
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
            height: 10.0,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 17, right: 17),
            child: Text(
              article.content,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Card(
            color: Color.fromRGBO(246, 246, 246, 1.0),
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
                                  image: NetworkImage(article.authorImg),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        article.author,
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
                      "${article.biography}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
