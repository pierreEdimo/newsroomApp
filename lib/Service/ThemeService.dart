import 'dart:convert';

import 'package:Newsroom/Model/ThemeModel.dart';
import 'package:http/http.dart';

class ThemeService {
  final String url = "https://findadoc.azurewebsites.net/api/Theme?sortBy=name";

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
}
