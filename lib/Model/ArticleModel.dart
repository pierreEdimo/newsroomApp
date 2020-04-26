import 'package:flutter/foundation.dart';

class Article {
  final int id;
  final String title;
  final String imageUrl;
  final String content;
  final int autorId;
  final String createdAt;
  final Author author;

  Article(
      {@required this.id,
      @required this.title,
      @required this.imageUrl,
      @required this.content,
      @required this.autorId,
      @required this.author,
      @required this.createdAt});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        id: json['id'] as int,
        title: json['title'] as String,
        imageUrl: json['imageUrl'] as String,
        content: json['content'] as String,
        autorId: json['autorId'] as int,
        createdAt: json['createdAt'] as String,
        author: Author.fromJson(json['author']));
  }
}

class Author {
  final int id;
  final String name;
  final String imageUrl;
  final biography;

  Author(
      {@required this.id,
      @required this.biography,
      @required this.name,
      @required this.imageUrl});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
        biography: json['biography'] as String,
        id: json['id'] as int,
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as String);
  }
}
