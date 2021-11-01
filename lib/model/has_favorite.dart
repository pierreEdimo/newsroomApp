class HasFavorite {
  final int? articleId;
  final String? ownerId;

  HasFavorite({
    this.articleId,
    this.ownerId,
  });

  factory HasFavorite.fromJson(Map<String, dynamic> json) => HasFavorite(
        articleId: json['articleId'] as int,
        ownerId: json['ownerId'] as String,
      );
}
