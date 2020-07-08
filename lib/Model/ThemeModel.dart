import 'package:flutter/foundation.dart';

import 'ArticleModel.dart';

class ThemeModel {
  final int id;
  final String name;
  final String imageUrl;
  List<Article> articles;

  ThemeModel(
      {@required this.id,
      @required this.name,
      @required this.imageUrl,
      @required this.articles});

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
        id: json['id'] as int,
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as String,
        articles: List<Article>.from(
            json['articles'].map((x) => Article.fromJson(x))));
  }
}
