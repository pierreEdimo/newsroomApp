import 'dart:convert';

import 'package:Newsroom/Model/SearchWord.dart';
import 'package:http/http.dart';

import '../main.dart';

class SearchService {
  Future<List<SearchWord>> getWords() async {
    String jwt = await storage.read(key: "jwt");
    Response res = await get(
      'https://newsplace.azurewebsites.net/api/SearchWords?sortOrder=desc',
      headers: {'Authorization': 'Bearer ' + jwt},
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<SearchWord> words =
          body.map((dynamic item) => SearchWord.fromJson(item)).toList();

      return words;
    } else {
      throw " can't get articles";
    }
  }

  Future<Response> addWord(String word, String userId) async {
    String jwt = await storage.read(key: "jwt");
    return post(
      'https://newsplace.azurewebsites.net/api/SearchWords',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + jwt
      },
      body: jsonEncode(
        {
          'userId': userId,
          'keyWord': word,
        },
      ),
    );
  }

  Future<Response> deleteWord(int id) async {
    String jwt = await storage.read(key: "jwt");
    final Response res = await delete(
      'https://newsplace.azurewebsites.net/api/SearchWords/$id',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + jwt
      },
    );
    return res;
  }
}
