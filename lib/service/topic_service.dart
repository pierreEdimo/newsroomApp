import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:newsroom/model/topic.dart';

class TopicService extends ChangeNotifier {
  Future<List<Topic>> fetchTopics() async {
    Response response =
        await get("https://newsplace.azurewebsites.net/api/Topics");

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Topic> topics =
          body.map((dynamic topic) => Topic.fromJson(topic)).toList();
      notifyListeners();
      return topics;
    } else {
      throw "No Topics";
    }
  }
}
