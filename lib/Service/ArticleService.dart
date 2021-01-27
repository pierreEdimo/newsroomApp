import 'dart:convert';

import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:Newsroom/Model/FavoriteArticleModel.dart';

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
        'https://newsplace.azurewebsites.net/api/Article/GetArticleFromAuthor?authorId=$authorId');

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
        'https://newsplace.azurewebsites.net/api/Article/$id',
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
      'https://newsplace.azurewebsites.net/api/Article?title=$title',
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

  Future<List<FavoriteModel>> getFavArticles(String userId) async {
    String jwt = await storage.read(key: "jwt");
    Response res = await get(
      'https://newsplace.azurewebsites.net/api/Favorites?userId=$userId',
      headers: {'Authorization': 'Bearer ' + jwt},
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<FavoriteModel> articles =
          body.map((dynamic item) => FavoriteModel.fromJson(item)).toList();

      return articles;
    } else {
      throw " Favorite not found";
    }
  }

  Future<int> deleteFavorite(int id) async {
    String jwt = await storage.read(key: "jwt");

    final Response response = await delete(
      'https://newsplace.azurewebsites.net/api/Favorites/$id',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + jwt
      },
    );

    print(response.statusCode);
    return response.statusCode;
  }

  Future<int> addToFavorites(String userId, int articleId) async {
    String jwt = await storage.read(key: "jwt");

    Response res = await post(
      'https://newsplace.azurewebsites.net/api/Favorites',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + jwt
      },
      body: jsonEncode(
        {'userId': userId, 'articleId': articleId},
      ),
    );

    return res.statusCode;
  }
}
