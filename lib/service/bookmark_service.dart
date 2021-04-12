import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:newsroom/model/add_bookmark.dart';
import 'package:newsroom/model/bookmark.dart';

import '../main.dart';

class BookMarkSerivce extends ChangeNotifier {
  Future<int> addBookMark(
    AddBookMark bookMark,
  ) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsEncode;
    jsEncode = jsonEncode(bookMark);
    final Response response = await post(
        'https://newsplace.azurewebsites.net/api/FavoritesArticles',
        headers: headers,
        body: jsEncode);
    notifyListeners();
    return response.statusCode;
  }

  Future<List<BookMark>> fetchBookMark() async {
    String userId = await storage.read(key: "userId");
    Response response = await get(
        'https://newsplace.azurewebsites.net/api/FavoritesArticles/FilterFavorites?UserId=$userId&&SortOrder=asc');

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<BookMark> articles = body
          .map(
            (dynamic article) => BookMark.fromJson(article),
          )
          .toList();
      notifyListeners();
      return articles;
    } else {
      throw "No Articles";
    }
  }

  Future<int> deleteFavorite(int id) async {
    String jwt = await storage.read(key: "jwt");
    final Response response = await delete(
      'https://newsplace.azurewebsites.net/api/FavoritesArticles/$id',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + jwt,
      },
    );
    notifyListeners();
    return response.statusCode;
  }
}
