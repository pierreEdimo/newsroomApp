import 'package:Newsroom/Model/UserModel.dart';
import 'package:flutter/foundation.dart';

class AddCommentModel {
  final String content;
  final String uid;
  final int articleId;

  AddCommentModel({
    @required this.content,
    @required this.uid,
    @required this.articleId,
  });

  factory AddCommentModel.fromJson(Map<String, dynamic> json) =>
      AddCommentModel(
          articleId: json['articleId'] as int,
          content: json['content'] as String,
          uid: json['uid'] as String);

  Map<String, dynamic> toJson() => {
        "articleId": articleId,
        "content": content,
        "uid": uid,
      };
}

class GetCommentModel {
  final int id;
  final String content;
  final String uid;
  final UserModel author;
  final int articleId;
  final String createdAt;

  GetCommentModel(
      {@required this.id,
      @required this.content,
      @required this.uid,
      @required this.author,
      @required this.createdAt,
      @required this.articleId});

  factory GetCommentModel.fromJson(Map<String, dynamic> json) =>
      GetCommentModel(
        id: json['id'] as int,
        content: json['content'] as String,
        uid: json['uid'] as String,
        articleId: json['articleId'] as int,
        createdAt: json['createdAt'] as String,
        author: UserModel.fromJson(json['author']),
      );
}
