import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:newsroom/main.dart';
import 'package:newsroom/model/add_saved_word.dart';

class SavedWordService extends ChangeNotifier {
  Future<Response> addSevedWord(AddSavedWord word) async {
    String? authorization = await storage.read(key: "jwt");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + authorization!
    };
    String jsEncode = jsonEncode(word);
    var url = Uri.parse('https://newsplace.azurewebsites.net/api/keywords');
    final Response response = await post(url, headers: headers, body: jsEncode);
    notifyListeners();
    return response;
  }

  Future<List<String>> fetchSavedWords() async {
    String? userId = await storage.read(key: "userId");
    String? authorization = await storage.read(key: "jwt");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + authorization!
    };
    var url = Uri.parse(
        "https://newsplace.azurewebsites.net/api/keyWords/QueryWord?userId=$userId");
    Response response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      List<String> savedWords =
          List<String>.from(jsonDecode(response.body).map((x) => x));

      for (int i = 0; i < savedWords.length; i++) {
        print(savedWords[i]);
      }

      return savedWords;
    } else {
      throw "No savedwords";
    }
  }
}
