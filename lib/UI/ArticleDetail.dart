import 'package:findadoctor/Model/ArticleModel.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ArticleFromAuthor.dart';

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
          style: TextStyle(color: Colors.black),
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
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("by ${article.author}"),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 17, right: 17),
            child: Text(
              article.content,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 17),
            alignment: Alignment.bottomRight,
            child: Text("vor 8 stunden"),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ArticleFromAuthor(
                        article: article,
                      )));
            },
            child: Card(
              color: Color.fromRGBO(246, 246, 246, 0.8),
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
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
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        article.author,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 360,
                      child: Text(
                        " Biography:${article.biography}",
                        style: TextStyle(fontSize: 20.0),
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
  }
}
