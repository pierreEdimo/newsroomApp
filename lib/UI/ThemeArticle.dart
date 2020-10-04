import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:Newsroom/Model/ThemeModel.dart';
import 'package:Newsroom/UI/ArticleDetail.dart';
import 'package:Newsroom/UI/SearchPage.dart';
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
          elevation: 0,
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
          actions: <Widget>[
            IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.search,
                  color: Colors.black,
                  size: 18,
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()))),
          ]),
      body: Center(
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: themeData.articles.length,
          itemBuilder: (BuildContext context, int index) {
            Article article = themeData.articles[index];
            return Container(
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ArticleDetail(
                            article: article,
                            favId: 0,
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
                                  image: NetworkImage(article.imageUrl),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 20.0),
                          alignment: Alignment.center,
                          width: 500,
                          height: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 20.0),
                          alignment: Alignment.bottomLeft,
                          width: 500,
                          height: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
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
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
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
