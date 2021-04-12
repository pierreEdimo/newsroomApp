class AddComment {
  final String authorId;
  final String content;
  final int articleId;

  AddComment({
    this.authorId,
    this.content,
    this.articleId,
  });

  factory AddComment.fromJson(Map<String, dynamic> json) => AddComment(
        authorId: json['authorId'] as String,
        content: json['content'] as String,
        articleId: json['articleId'] as int,
      );

  Map<String, dynamic> toJson() => {
        "authorId": authorId,
        "content": content,
        "articleId": articleId,
      };
}
