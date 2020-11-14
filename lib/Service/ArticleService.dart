import 'dart:convert';

import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:Newsroom/Model/Favorite.dart';
import 'package:Newsroom/Model/FavoritesArticle.dart';
import 'package:Newsroom/Model/Suggestion.dart';
import 'package:Newsroom/main.dart';
import 'package:http/http.dart';

class ArticleService {
  final String articleUrl = "";

  Future<List<Article>> getArticles() async {
    Response res = await get(
        'https://findadoc.azurewebsites.net/api/Article?sortBy=title&sortOrder=desc');

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw " can't get articles";
    }
  }

  Future<List<Favorite>> getFavorites(String uid) async {
    String jwt = await storage.read(key: "jwt");
    Response res = await get(
      'https://findadoc.azurewebsites.net/api/Favorite?userId=$uid',
      headers: {'Authorization': 'Bearer ' + jwt},
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Favorite> favorites =
          body.map((dynamic item) => Favorite.fromJson(item)).toList();

      return favorites;
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

  Future<int> addFavorite(AddFavoriteArticleModel favoriteArticleModel) async {
    String authorization = await storage.read(key: "jwt");

    String jsEncode;
    jsEncode = jsonEncode(favoriteArticleModel);
    final Response response = await post(
        'https://findadoc.azurewebsites.net/api/FavoriteArticles',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + authorization
        },
        body: jsEncode);
    print(response.statusCode);
    return response.statusCode;
  }

  //Future<int> deleteFavorite(int id) async {}##

  Future<int> deleteFavorite(int id) async {
    String jwt = await storage.read(key: "jwt");

    final Response response = await delete(
      'https://findadoc.azurewebsites.net/api/FavoriteArticles/$id',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + jwt
      },
    );

    print(response.statusCode);
    return response.statusCode;
  }

  Future<List<Suggestion>> getSuggestions() async {
    String jwt = await storage.read(key: "jwt");
    Response res = await get(
      'https://findadoc.azurewebsites.net/api/Suggestions',
      headers: {'Authorization': 'Bearer ' + jwt},
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Suggestion> articles =
          body.map((dynamic item) => Suggestion.fromJson(item)).toList();

      return articles;
    } else {
      throw "Article not found";
    }
  }
}
