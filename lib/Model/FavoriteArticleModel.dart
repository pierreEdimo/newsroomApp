import 'package:Newsroom/Model/ArticleModel.dart';
import 'package:flutter/foundation.dart';

class FavoriteModel {
  final String userId;
  final Article article;
  final int articleId;

  FavoriteModel(
      {@required this.article,
      @required this.userId,
      @required this.articleId});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        article: Article.fromJson(json['article']),
        userId: json['userId'] as String,
        articleId: json['articleId'] as int,
      );
}
