import 'package:flutter/foundation.dart';

import 'ArticleModel.dart';

class Favorite {
  final int articleId;
  final String uid;
  final Article article;

  Favorite(
      {@required this.article, @required this.uid, @required this.articleId});

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
      articleId: json['articleId'] as int,
      article: Article.fromJson(json['article']),
      uid: json['userId'] as String);
}
