import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:Newsroom/Model/ThemeModel.dart';
import 'package:Newsroom/UI/ArticleDetail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ThemeArticleList extends StatefulWidget {
  final ThemeModel themeData;

  ThemeArticleList({Key key, @required this.themeData}) : super(key: key);

  @override
  _ThemeArticleListState createState() =>
      _ThemeArticleListState(themeData: this.themeData);
}

class _ThemeArticleListState extends State<ThemeArticleList> {
  ThemeModel themeData;

  _ThemeArticleListState({@required this.themeData});

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
          style: TextStyle(color: Colors.black, fontFamily: 'OpenSans'),
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
              margin: EdgeInsets.only(bottom: 25),
              child: InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ArticleDetail(
                          article: article,
                        ))),
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
                                fontSize: 16.0,
                                fontFamily: 'OpenSans'),
                          ),
                          subtitle: Text("By ${article.author}"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 5.0, left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Am 06-07-20"),
                            IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.ellipsisV,
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
            );
          },
        ),
      ),
    );
  }
}
