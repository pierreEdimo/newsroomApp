import 'dart:convert';
import 'package:newsroom/main.dart';
import 'package:newsroom/model/add_bookmark.dart';
import 'package:newsroom/model/article.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:newsroom/service/bookmark_service.dart';

class ArticleService extends ChangeNotifier {
  final BookMarkService _bookMarkService = BookMarkService();
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
    String? userId = await storage.read(key: "userId");
    var url = Uri.parse(
        'https://newsplace.azurewebsites.net/api/Articles/$id?UserId=$userId');
    Response response = await get(url);
    if (response.statusCode == 200) {
      return Article.fromJson(jsonDecode(response.body));
    } else {
      throw "Failed to load Article";
    }
  }

  Future<void> addBookMark(Article article, AddBookMark bookMark) async {
    var oldStatus = article.isFavorite;
    article.isFavorite = !article.isFavorite!;
    notifyListeners();
    try {
      if (oldStatus == false) {
        await _bookMarkService.addBookMark(bookMark);
      } else {
        await _bookMarkService.deleteFavorite(article);
      }
    } catch (error) {
      article.isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
