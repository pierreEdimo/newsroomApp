import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:newsroom/model/add_bookmark.dart';
import 'package:newsroom/model/article.dart';
import '../main.dart';

class BookMarkService extends ChangeNotifier {
  Future<void> addBookMark(
    AddBookMark bookMark,
  ) async {
    String? authorization = await storage.read(key: "jwt");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + authorization!
    };
    String jsEncode = jsonEncode(bookMark);
    var url =
        Uri.parse('https://newsplace.azurewebsites.net/api/FavoritesArticles');
    final Response response = await post(
      url,
      headers: headers,
      body: jsEncode,
    );
    print(response.statusCode);
    notifyListeners();
  }

  Future<void> deleteFavorite(Article article) async {
    String? jwt = await storage.read(key: "jwt");
    var url = Uri.parse(
        'https://newsplace.azurewebsites.net/api/FavoritesArticles/${article.id}');
    await delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + jwt!,
      },
    );
    notifyListeners();
  }
}
