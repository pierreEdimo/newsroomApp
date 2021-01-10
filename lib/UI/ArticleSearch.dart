import 'package:Newsroom/Component/SearchResult.dart';
import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:Newsroom/Model/SearchWord.dart';
import 'package:Newsroom/Service/ArticleService.dart';
import 'package:Newsroom/Service/SearchWordService.dart';
import 'package:Newsroom/UI/ArticleDetailScreen.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ArticleSearch extends StatefulWidget {
  @override
  _ArticleSearchState createState() => _ArticleSearchState();
}

class _ArticleSearchState extends State<ArticleSearch> {
  Future<List<Article>> _articles;
  final ArticleService _articleService = ArticleService();
  final TextEditingController _articleController = TextEditingController();
  final SearchService _searchService = SearchService();
  Future<List<SearchWord>> _words;

  @override
  void initState() {
    super.initState();
    _words = _fetchWords();
  }

  Future<List<SearchWord>> _fetchWords() {
    return _searchService.getWords();
  }

  Future<void> _loadWords() async {
    setState(() {
      _words = _fetchWords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            child: TextField(
              autofocus: true,
              textInputAction: TextInputAction.search,
              controller: _articleController,
              onSubmitted: (value) async {
                String userId = await storage.read(key: 'userId');
                value = _articleController.text;
                setState(() {
                  _articles = _articleService
                      .getArticlesForSearch(_articleController.text);
                });
                _searchService.addWord(_articleController.text, userId);
                _articleController.clear();
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20.0),
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    _articleController.clear();
                    setState(() {
                      _articles = null;
                    });
                    _loadWords();
                  },
                ),
                hintText: "Search Article...",
                hintStyle: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: _articles == null
                  ? FutureBuilder(
                      future: _words,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<SearchWord> words = snapshot.data;

                          return ListView(
                            padding: EdgeInsets.all(0.0),
                            children: words
                                .map((SearchWord word) => InkWell(
                                      onTap: () {
                                        setState(() {
                                          _articles = _articleService
                                              .getArticlesForSearch(
                                                  word.keyWord);
                                        });
                                        _articleController.text = word.keyWord;
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 20.0),
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.history_outlined,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(word.keyWord)
                                              ],
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.delete_outlined,
                                                  color: Colors.black),
                                              onPressed: () async =>
                                                  _searchService
                                                      .deleteWord(word.id)
                                                      .then(
                                                        (_) => _loadWords(),
                                                      ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    )
                  : FutureBuilder(
                      future: _articles,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Article> articles = snapshot.data;

                          return articles.length < 1
                              ? Center(
                                  child: Text("Not Found!, please try again"),
                                )
                              : ListView(
                                  padding: EdgeInsets.all(0.0),
                                  children: articles
                                      .map(
                                        (Article article) => InkWell(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      ArticleDetailScreen(
                                                          articleId: article.id,
                                                          authorId: article
                                                              .autorId))),
                                          child: searchResult(
                                              article.imageUrl,
                                              article.title,
                                              article.author.name,
                                              article.createdAt,
                                              article.author.imageUrl),
                                        ),
                                      )
                                      .toList(),
                                );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}
