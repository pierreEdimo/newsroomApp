class Author {
  final int id;
  final String name;

  Author({
    this.id,
    this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json['id'] as int,
        name: json['name'] as String,
      );
}
