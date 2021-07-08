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
    String jsEncode = jsonEncode(bookMark);
    var url =
        Uri.parse('https://newsplace.azurewebsites.net/api/FavoritesArticles');
    final Response response = await post(
      url,
      headers: headers,
      body: jsEncode,
    );

    return response.statusCode;
  }

  Future<List<BookMark>> fetchBookMark() async {
    String? userId = await storage.read(key: "userId");
    var url = Uri.parse(
        'https://newsplace.azurewebsites.net/api/FavoritesArticles/FilterFavorites?UserId=$userId&&SortOrder=asc');
    Response response = await get(url);

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
    String? jwt = await storage.read(key: "jwt");
    var url = Uri.parse(
        'https://newsplace.azurewebsites.net/api/FavoritesArticles/$id');
    final Response response = await delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + jwt!,
      },
    );
    notifyListeners();
    return response.statusCode;
  }
}
