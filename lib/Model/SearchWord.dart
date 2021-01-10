import 'package:flutter/foundation.dart';

class SearchWord {
  final int id;
  final String keyWord;

  SearchWord({@required this.id, @required this.keyWord});

  factory SearchWord.fromJson(Map<String, dynamic> json) => SearchWord(
        id: json['id'] as int,
        keyWord: json['keyWord'] as String,
      );
}
