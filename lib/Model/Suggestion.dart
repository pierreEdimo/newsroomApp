import 'package:flutter/foundation.dart';

import 'ArticleModel.dart';

class Suggestion {
  final int id;
  final int articleId;
  final Article article;

  Suggestion(
      {@required this.id, @required this.articleId, @required this.article});

  factory Suggestion.fromJson(Map<String, dynamic> json) => Suggestion(
        id: json['id'] as int,
        articleId: json['articleId'] as int,
        article: Article.fromJson(json['article']),
      );
}
