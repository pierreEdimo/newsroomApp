import 'package:flutter/material.dart';
import 'package:findadoctor/Model/ArticleModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArticleDetailFromAuthor extends StatelessWidget {
  final Article article;

  ArticleDetailFromAuthor({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: FaIcon(FontAwesomeIcons.arrowLeft,
                color: Colors.black, size: 18),
            onPressed: () => Navigator.of(context).pop()),
        title: Text(
          article.title,
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: FaIcon(FontAwesomeIcons.bookmark,
                color: Colors.black, size: 18),
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
                    image: NetworkImage(article.imageUrl), fit: BoxFit.cover)),
          ),
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
          )
        ],
      ),
    );
  }
}
