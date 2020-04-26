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
              FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.black, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.ellipsisV,
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
            subtitle: Text("by ${article.author.name}"),
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
            child: Text("vor 8 stunden"),
          ),
          Card(
            color: Color.fromRGBO(246, 246, 246, 0.8),
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Container(
                    width: 360,
                    child: Text(
                      " Biography:${article.author.biography}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
