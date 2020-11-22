import 'package:Newsroom/Component/Custom.Card.dart';
import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:Newsroom/Service/ArticleService.dart';
import 'package:Newsroom/UI/ArticleDetailScreen.dart';
import 'package:flutter/material.dart';

//import 'ArticleDetailScreen.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<List<Article>> articlesFound;
  Future<List<Article>> _suggestions;
  ArticleService _articleService = ArticleService();
  String _url =
      "https://findadoc.azurewebsites.net/api/Article?sortBy=title&sortOrder=desc";

  TextEditingController _searchWord = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchSuggestions();
  }

  void clearSearch() {
    setState(() {
      _searchWord.clear();
      articlesFound = null;
    });
  }

  void search(String newSearch) {
    setState(() {
      articlesFound = _articleService.getArticlesForSearch(newSearch);
    });
  }

  _fetchSuggestions() {
    _suggestions = _articleService.getArticles(_url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                    bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                )),
              ),
              child: TextField(
                controller: _searchWord,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(30.0),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => clearSearch(),
                  ),
                  hintText: "Search an Article",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                onChanged: (string) {
                  setState(() {
                    string = _searchWord.text;
                    search(_searchWord.text);
                  });
                },
              ),
            ),
            Expanded(
              child: articlesFound == null
                  ? Container(
                      child: FutureBuilder(
                        future: _suggestions,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Article> suggestions = snapshot.data;

                            return ListView(
                              padding: EdgeInsets.all(20.0),
                              children: suggestions
                                  .map((Article suggestion) => Container(
                                        margin: EdgeInsets.only(bottom: 20.0),
                                        child: InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ArticleDetailScreen(
                                                          articleId:
                                                              suggestion.id,
                                                          authorId: suggestion
                                                              .autorId))),
                                          child: customCard(
                                              suggestion.title,
                                              suggestion.imageUrl,
                                              400,
                                              20,
                                              250,
                                              suggestion.author.imageUrl,
                                              suggestion.author.name,
                                              suggestion.createdAt),
                                        ),
                                      ))
                                  .toList(),
                            );
                          }
                          return Center(child: Text(""));
                        },
                      ),
                    )
                  : FutureBuilder(
                      future: articlesFound,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Article>> snapshot) {
                        if (snapshot.hasData) {
                          List<Article> articles = snapshot.data;

                          return articles.length < 1
                              ? Center(
                                  child: Text("Not Found"),
                                )
                              : ListView(
                                  padding: EdgeInsets.all(20.0),
                                  children: articles
                                      .map(
                                        (Article article) => Container(
                                          margin: EdgeInsets.only(bottom: 20.0),
                                          child: InkWell(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ArticleDetailScreen(
                                                  articleId: article.id,
                                                  authorId: article.autorId,
                                                ),
                                              ),
                                            ),
                                            child: customCard(
                                                article.title,
                                                article.imageUrl,
                                                400,
                                                20,
                                                250,
                                                article.author.imageUrl,
                                                article.author.name,
                                                article.createdAt),
                                          ),
                                        ),
                                      )
                                      .toList());
                        }
                        return Center(
                          child: Text(""),
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }
}
