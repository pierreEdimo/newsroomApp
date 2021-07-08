import 'package:newsroom/model/user_,model.dart';

class Comment {
  final int? id;
  final String? createdAt;
  final int? articleId;
  final UserModel? author;
  final String? content;
  final String? authorId;

  Comment(
      {this.articleId,
      this.id,
      this.content,
      this.author,
      this.createdAt,
      this.authorId});

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        articleId: json['articleId'] as int,
        content: json['content'] as String,
        id: json['id'] as int,
        createdAt: json['createdAt'] as String,
        authorId: json['authorId'] as String,
        author: UserModel.fromJson(json['author']),
      );
}
