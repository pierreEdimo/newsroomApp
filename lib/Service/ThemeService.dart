import 'dart:convert';

import 'package:Newsroom/Model/ThemeModel.dart';
import 'package:Newsroom/main.dart';
import 'package:http/http.dart';

class ThemeService {
  final String url =
      "https://newsplace.azurewebsites.net/api/Theme?sortBy=name";

  Future<List<ThemeModel>> getAllThemes() async {
    Response res = await get(url);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<ThemeModel> themes =
          body.map((dynamic item) => ThemeModel.fromJson(item)).toList();

      return themes;
    } else {
      throw "can't get a Theme";
    }
  }

  Future<ThemeModel> getAThemebyId(int id) async {
    String jwt = await storage.read(key: "jwt");

    Response res = await get(
      "https://newsplace.azurewebsites.net/api/Theme/$id",
      headers: {'Authorization': 'Bearer ' + jwt},
    );

    if (res.statusCode == 200) {
      return ThemeModel.fromJson(jsonDecode(res.body));
    } else {
      throw "can't get a Theme";
    }
  }
}
