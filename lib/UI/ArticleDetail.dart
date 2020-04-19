import 'package:findadoctor/Model/ArticleModel.dart';
import 'package:findadoctor/Service/ArticleService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArticleDetail extends StatelessWidget {
  final Article article;
  final ArticleService articleService = new ArticleService();

  ArticleDetail({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon:
              FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.black, size: 22),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "healthAvice",
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: 700,
            height: 250,
            child: Image.network(article.imageUrl),
          ),
          ListTile(
            title: Text(
              article.title,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20.0),
            child: Text(
              article.content,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.bottomRight,
            child: Text("Am ${article.createdAt}"),
          )
        ],
      ),
    );
  }
}
