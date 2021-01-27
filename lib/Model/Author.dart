import 'package:flutter/cupertino.dart';

class Author {
  final int id;
  final String name;
  final String biography;

  Author({
    @required this.biography,
    @required this.id,
    @required this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        biography: json['biography'] as String,
        id: json['id'] as int,
        name: json['name'] as String,
      );
}
