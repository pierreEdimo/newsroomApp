import 'dart:convert';

import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:Newsroom/Model/FavoritesArticle.dart';
import 'package:Newsroom/main.dart';
import 'package:http/http.dart';

class ArticleService {
  final String articleUrl =
      "https://findadoc.azurewebsites.net/api/Article?sortBy=title&sortOrder=desc";

  Future<List<Article>> getArticles() async {
    Response res = await get(articleUrl);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw " can't get articles";
    }
  }

  Future<List<GetFavoriteArticleModel>> getFovites(String userId) async {
    String jwt = await storage.read(key: "jwt");
    Response res = await get(
        'https://findadoc.azurewebsites.net/api/FavoriteArticles?userId=$userId',
        headers: {'Authorization': 'Bearer ' + jwt});

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<GetFavoriteArticleModel> articles = body
          .map((dynamic item) => GetFavoriteArticleModel.fromJson(item))
          .toList();

      return articles;
    } else {
      throw "Can't get articles";
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

  Future<int> deleteAnswer(int id) async {
    String jwt = await storage.read(key: "jwt");

    final Response response = await delete(
      'https://findadoc.azurewebsites.net/api/Answers/$id',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + jwt
      },
    );

    print(response.statusCode);
    return response.statusCode;
  }
}
