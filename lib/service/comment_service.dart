import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newsroom/main.dart';
import 'package:newsroom/model/add_comment.dart';
import 'package:newsroom/model/comment.dart';

class CommentService extends ChangeNotifier {
  Future<List<Comment>> fetchComments(
    int id,
  ) async {
    var url = Uri.parse(
        'https://newsplace.azurewebsites.net/api/Comments/FilterComments?ArticleId=$id');
    Response response = await get(url);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Comment> comments = body
          .map(
            (dynamic comment) => Comment.fromJson(comment),
          )
          .toList();
      return comments;
    } else {
      throw "No Articles";
    }
  }

  Future<Response> addComment(
    AddComment comment,
  ) async {
    var jwt = await storage.read(key: 'jwt'); 
    Map<String, String> headers = {'Content-Type': 'application/json' , 'Authorization': 'Bearer ' + jwt!  };
    String jsEncode = jsonEncode(comment);
    var url = Uri.parse('https://newsplace.azurewebsites.net/api/comments');
    final Response response = await post(url, headers: headers, body: jsEncode);
    notifyListeners();
    return response;
  }

  Future<Response> deleteComment(int id) async {
    var jwt = await storage.read(key: 'jwt');
    var url = Uri.parse('https://newsplace.azurewebsites.net/api/Comments/$id');
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer '+ jwt! };
    Response response = await delete(
      url,
      headers: headers ,
    );
    notifyListeners();
    return response;
  }

  Future<Response> updateComment(
    AddComment comment,
    int id,
  ) async {
    String jsEncode = jsonEncode(comment);
    var jwt = await storage.read(key: 'jwt');
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer '+ jwt! };
    var url = Uri.parse("https://newsplace.azurewebsites.net/api/Comments/$id");
    Response response = await put(
      url,
      headers: headers,
      body: jsEncode,
    );

    notifyListeners();
    return response;
  }
}
