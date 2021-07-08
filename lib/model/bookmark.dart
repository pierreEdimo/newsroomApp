class BookMark {
  final int? articleId;
  final ArticleBookMark? article;

  BookMark({
    this.articleId,
    this.article,
  });

  factory BookMark.fromJson(Map<String, dynamic> json) => BookMark(
        articleId: json['articleId'] as int,
        article: ArticleBookMark.fromJson(
          json['article'],
        ),
      );
}

class ArticleBookMark {
  final int? id;
  final String? title;
  final String? content;
  final String? imageUrl;

  ArticleBookMark({
    this.id,
    this.title,
    this.content,
    this.imageUrl,
  });

  factory ArticleBookMark.fromJson(Map<String, dynamic> json) =>
      ArticleBookMark(
        id: json['id'] as int,
        title: json['title'] as String,
        content: json['content'] as String,
        imageUrl: json['imageUrl'] as String,
      );
}
