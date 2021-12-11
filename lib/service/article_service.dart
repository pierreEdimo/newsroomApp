import 'dart:convert';
import 'package:newsroom/model/article.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';


class ArticleService extends ChangeNotifier {
  Future<List<Article>> fetchArticles(String uri) async {

    var url = Uri.parse(uri);
    Response response = await get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Article> articles =
          body.map((dynamic article) => Article.fromJson(article)).toList();
      notifyListeners();
      return articles;
    } else {
      throw "No Articles";
    }
  }

  Future<Article> fetchArticle(int id) async {
    var url = Uri.parse('https://newsplace.azurewebsites.net/api/Articles/$id');
    Response response = await get(url);

    if (response.statusCode == 200) {
      notifyListeners();
      return Article.fromJson(jsonDecode(response.body));
    } else {
      throw "Failed to load Article";
    }
  }
}
