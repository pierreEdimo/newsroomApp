import 'package:flutter/foundation.dart';

class Article {
  final int id;
  final String title;
  final String imageUrl;
  final String content;
  final int autorId;
  final String createdAt;
  final String author;
  final String biography;
  final String authorImg;

  Article(
      {@required this.id,
      @required this.title,
      @required this.imageUrl,
      @required this.content,
      @required this.autorId,
      @required this.createdAt,
      @required this.author,
      @required this.biography,
      @required this.authorImg});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        id: json['id'] as int,
        title: json['title'] as String,
        imageUrl: json['imageUrl'] as String,
        content: json['content'] as String,
        autorId: json['autorId'] as int,
        createdAt: json['createdAt'] as String,
        author: json['author'] as String,
        biography: json['biography'] as String,
        authorImg: json['authorImg'] as String);
  }
}
