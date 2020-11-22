import 'dart:convert';

import 'package:Newsroom/Model/ArticleModel.dart';

import 'package:Newsroom/main.dart';
import 'package:http/http.dart';

class ArticleService {
  Future<List<Article>> getArticles(String url) async {
    String jwt = await storage.read(key: "jwt");
    Response res = await get(
      url,
      headers: {'Authorization': 'Bearer ' + jwt},
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw " can't get articles";
    }
  }

  Future<List<Article>> getArticleFromAuthor(int authorId) async {
    Response res = await get(
        'https://findadoc.azurewebsites.net/api/Article/GetArticleFromAuthor?authorId=$authorId');

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw " can't get articles";
    }
  }

  Future<Article> fetchArticle(int id) async {
    String jwt = await storage.read(key: "jwt");
    Response res = await get(
        'https://findadoc.azurewebsites.net/api/Article/$id',
        headers: {'Authorization': 'Bearer ' + jwt});

    if (res.statusCode == 200) {
      return Article.fromJson(jsonDecode(res.body));
    } else {
      throw "can't fetch this article";
    }
  }

  Future<List<Article>> getArticlesForSearch(String title) async {
    String jwt = await storage.read(key: "jwt");
    Response res = await get(
      'https://findadoc.azurewebsites.net/api/Article?title=$title',
      headers: {'Authorization': 'Bearer ' + jwt},
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw "Article not found";
    }
  }
}
