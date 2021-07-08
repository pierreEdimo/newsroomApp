import 'author.dart';

class Article {
  final int? id;
  final String? title;
  final String? imageUrl;
  final String? content;
  final String? createdAt;
  final Author? author;
  final int? commentCount;
  final String? imageCredits;

  Article({
    this.content,
    this.id,
    this.createdAt,
    this.imageCredits,
    this.imageUrl,
    this.title,
    this.author,
    this.commentCount,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        content: json['content'] as String,
        id: json['id'] as int,
        title: json['title'] as String,
        createdAt: json['createdAt'] as String,
        imageUrl: json['imageUrl'] as String,
        commentCount: json['commentCount'] as int,
        imageCredits: json['imageCredits'] as String,
        author: Author.fromJson(json['author']),
      );
}
