import 'package:flutter/foundation.dart';

import 'UserModel.dart';

class AddForum {
  final String uid;
  final String title;

  AddForum({@required this.uid, @required this.title});

  factory AddForum.fromJson(Map<String, dynamic> json) =>
      AddForum(uid: json['uid'] as String, title: json['title '] as String);

  Map<String, dynamic> toJson() => {"uid": uid, "title": title};
}

class GetForum {
  final int id;
  final String uid;
  final String title;
  final UserModel author;

  GetForum(
      {@required this.id,
      @required this.uid,
      @required this.title,
      @required this.author});

  factory GetForum.fromJson(Map<String, dynamic> json) => GetForum(
      id: json['id'] as int,
      title: json['title'] as String,
      uid: json['uid'] as String,
      author: UserModel.fromJson(json['author']));
}
