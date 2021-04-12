import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:newsroom/model/add_comment.dart';
import 'package:newsroom/model/comment.dart';

class CommentService extends ChangeNotifier {
  Future<List<Comment>> fetchComments(
    int id,
  ) async {
    Response response = await get(
        'https://newsplace.azurewebsites.net/api/Comments/FilterComments?ArticleId=$id');

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Comment> comments = body
          .map(
            (dynamic comment) => Comment.fromJson(comment),
          )
          .toList();
      notifyListeners();
      return comments;
    } else {
      throw "No Articles";
    }
  }

  Future<Response> addComment(
    AddComment comment,
  ) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsEncode;
    jsEncode = jsonEncode(comment);
    final Response response = await post(
        'https://newsplace.azurewebsites.net/api/comments',
        headers: headers,
        body: jsEncode);
    notifyListeners();
    return response;
  }

  Future<Response> deleteComment(int id) async {
    Response response = await delete(
      'https://newsplace.azurewebsites.net/api/Comments/$id',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    notifyListeners();
    return response;
  }

  Future<Response> updateComment(
    AddComment comment,
    int id,
  ) async {
    String jsEncode;
    jsEncode = jsonEncode(comment);
    Response response =
        await put("https://newsplace.azurewebsites.net/api/Comments/$id",
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsEncode);

    notifyListeners();
    return response;
  }
}
