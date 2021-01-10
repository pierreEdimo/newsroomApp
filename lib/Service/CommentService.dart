import 'package:Newsroom/Model/CommentsModel.dart';
import 'package:http/http.dart';
import 'dart:convert';

import '../main.dart';

class CommentService {
  Future<int> comment(AddCommentModel commentModel) async {
    String jwt = await storage.read(key: "jwt");
    String jsEncode;
    jsEncode = jsonEncode(commentModel);
    final Response response = await post(
        'https://newsplace.azurewebsites.net/api/Comment',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + jwt
        },
        body: jsEncode);

    print(response.statusCode);
    return response.statusCode;
  }

  Future<List<GetCommentModel>> getComments(int articleId) async {
    String jwt = await storage.read(key: "jwt");
    Response response = await get(
        'https://newsplace.azurewebsites.net/api/Comment?articleId=$articleId&&sortOrder=desc',
        headers: {'Authorization': 'Bearer ' + jwt});

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<GetCommentModel> comments =
          body.map((dynamic item) => GetCommentModel.fromJson(item)).toList();

      return comments;
    } else {
      throw "error";
    }
  }

  Future<int> deleteComment(int id) async {
    String jwt = await storage.read(key: "jwt");

    final Response response = await delete(
      'https://newsplace.azurewebsites.net/api/Comment/$id',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + jwt
      },
    );

    print(response.statusCode);
    return response.statusCode;
  }

  Future<int> updateComment(
    int id,
    String uid,
    String content,
  ) async {
    String jwt = await storage.read(key: "jwt");

    final Response response = await put(
      'https://findadoc.azurewebsites.net/api/Comment/$id',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + jwt
      },
      body: jsonEncode({
        'id': id,
        'uid': uid,
        'content': content,
      }),
    );

    print(response.statusCode);
    return response.statusCode;
  }
}
