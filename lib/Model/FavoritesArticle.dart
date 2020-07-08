import 'package:flutter/foundation.dart';

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
