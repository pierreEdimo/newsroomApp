class AddBookMark {
  final String ownerId;
  final int articleId;

  AddBookMark({
    this.ownerId,
    this.articleId,
  });

  factory AddBookMark.fromJson(Map<String, dynamic> json) => AddBookMark(
        ownerId: json['ownerId'] as String,
        articleId: json['articleId'] as int,
      );

  Map<String, dynamic> toJson() => {
        "ownerId": ownerId,
        "articleId": articleId,
      };
}
