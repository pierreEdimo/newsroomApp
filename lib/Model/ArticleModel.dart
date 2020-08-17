import 'package:flutter/foundation.dart';

import 'Author.dart';

class Article {
  final int id;
  final String title;
  final String imageUrl;
  final String content;
  final int autorId;
  final String createdAt;
  final Author author;

  Article({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.content,
    @required this.autorId,
    @required this.createdAt,
    @required this.author,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
      id: json['id'] as int,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      content: json['content'] as String,
      autorId: json['autorId'] as int,
      createdAt: json['createdAt'] as String,
      author: Author.fromJson(json['author']));
}
