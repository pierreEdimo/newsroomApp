import 'package:flutter/foundation.dart';

import 'ArticleModel.dart';

class AddFavoriteArticleModel {
  final String userId;
  final int articleId;

  AddFavoriteArticleModel({
    @required this.userId,
    @required this.articleId,
  });

  factory AddFavoriteArticleModel.fromJson(Map<String, dynamic> json) =>
      AddFavoriteArticleModel(
        userId: json['userId'] as String,
        articleId: json['articleId'] as int,
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "articleId": articleId,
      };
}

class GetFavoriteArticleModel {
  final String userId;
  final Article article;
  final int id;

  GetFavoriteArticleModel(
      {@required this.userId, @required this.id, @required this.article});

  factory GetFavoriteArticleModel.fromJson(Map<String, dynamic> json) =>
      GetFavoriteArticleModel(
        userId: json["userId"],
        id: json["id"],
        article: Article.fromJson(json["article"]),
      );
}
