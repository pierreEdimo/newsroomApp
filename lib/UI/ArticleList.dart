import 'package:findadoctor/Model/ArticleModel.dart';
import 'package:findadoctor/Service/ArticleService.dart';
import 'package:findadoctor/UI/ArticleDetail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.asset('image/icon.png'),
        centerTitle: true,
        title: Text("Newsfeed",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans')),
        actions: <Widget>[
          IconButton(
            icon:
                FaIcon(FontAwesomeIcons.search, color: Colors.black, size: 18),
            onPressed: () {},
          )
        ],
      ),
      body: ArticleList(),
    );
  }
}

class ArticleList extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleList> {
  final ArticleService articleService = ArticleService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                margin: EdgeInsets.only(bottom: 25),
                                child: InkWell(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => ArticleDetail(
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
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5.0),
                                                topRight: Radius.circular(5.0)),
                                            child: Image.network(
                                              article.imageUrl,
                                              fit: BoxFit.fill,
                                            ),
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
                                              subtitle:
                                                  Text("By ${article.author}"),
                                            )),
                                        Container(
                                          padding: EdgeInsets.only(
                                            bottom: 5.0,
                                            left: 20.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text("Am 06-07-20"),
                                              IconButton(
                                                icon: FaIcon(
                                                  FontAwesomeIcons.bookmark,
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
                              ),
                            ))
                        .toList());
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.exclamationTriangle,
                        size: 80,
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Text(
                          "Error your phone is not connected to the internet, please try again later",
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                );
              }

              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
