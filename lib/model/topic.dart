class Topic {
  final int? id;
  final String? name;
  final String? imageUrl;

  Topic({
    this.id,
    this.imageUrl,
    this.name,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json['id'] as int,
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as String,
      );
}
