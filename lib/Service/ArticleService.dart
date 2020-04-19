import 'dart:convert';
import 'package:findadoctor/Model/ArticleModel.dart';
import 'package:http/http.dart';

class ArticleService {
  final String articleUrl = "https://findadoc.azurewebsites.net/api/Article";

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
}
