import 'package:Newsroom/Model/Answer.dart';
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
        'https://findadoc.azurewebsites.net/api/Comment',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + jwt
        },
        body: jsEncode);

    print(response.statusCode);
    return response.statusCode;
  }

  Future<List<GetAnsWer>> fetchAnswers() async {
    String jwt = await storage.read(key: "jwt");
    Response response = await get(
        'https://findadoc.azurewebsites.net/api/Answers',
        headers: {'Authorization': 'Bearer ' + jwt});

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<GetAnsWer> answers =
          body.map((dynamic item) => GetAnsWer.fromJson(item)).toList();

      return answers;
    } else {
      throw "error";
    }
  }

  Future<List<GetCommentModel>> getComments() async {
    String jwt = await storage.read(key: "jwt");
    Response response = await get(
        'https://findadoc.azurewebsites.net/api/Comment',
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

  Future<int> ansWerComment(AnsWer answerComment) async {
    String jwt = await storage.read(key: "jwt");
    String jsEncode;
    jsEncode = jsonEncode(answerComment);
    final Response response = await post(
        'https://findadoc.azurewebsites.net/api/Answers',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + jwt
        },
        body: jsEncode);

    print(response.statusCode);
    return response.statusCode;
  }
}
