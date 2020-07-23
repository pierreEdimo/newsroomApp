import 'package:flutter/foundation.dart';

import 'UserModel.dart';

class AnsWer {
  final String uid;
  final int commentId;
  final String content;

  AnsWer(
      {@required this.content, @required this.uid, @required this.commentId});

  factory AnsWer.fromJson(Map<String, dynamic> json) => AnsWer(
      uid: json['uid'] as String,
      content: json['content'] as String,
      commentId: json['commentId'] as int);

  Map<String, dynamic> toJson() =>
      {"uid": uid, "commentId": commentId, "content": content};
}

class GetAnsWer {
  final String uid;
  final int commentId;
  final String content;
  final int id;
  final UserModel author;

  GetAnsWer(
      {@required this.uid,
      @required this.commentId,
      @required this.content,
      @required this.id,
      @required this.author});

  factory GetAnsWer.fromJson(Map<String, dynamic> json) => GetAnsWer(
      uid: json['uid'] as String,
      id: json['id'] as int,
      content: json['content'] as String,
      author: UserModel.fromJson(json['author']),
      commentId: json['commentId'] as int);
}
