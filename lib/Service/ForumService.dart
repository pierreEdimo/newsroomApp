import 'package:Newsroom/Model/ForumModel.dart';
import 'package:http/http.dart';
import 'dart:convert';

import '../main.dart';

class ForumService {
  Future<int> addForum(AddForum forum) async {
    String jwt = await storage.read(key: "jwt");
    String jsEncode;
    jsEncode = jsonEncode(forum);
    final Response response = await post(
        'https://findadoc.azurewebsites.net/api/Forum',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + jwt
        },
        body: jsEncode);

    print(response.statusCode);
    return response.statusCode;
  }

  Future<List<GetForum>> getForums() async {
    String jwt = await storage.read(key: "jwt");
    Response response = await get(
        'https://findadoc.azurewebsites.net/api/Forum?sortOrder=desc',
        headers: {'Authorization': 'Bearer ' + jwt});

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<GetForum> forums =
          body.map((dynamic item) => GetForum.fromJson(item)).toList();

      return forums;
    } else {
      throw "error";
    }
  }
}
