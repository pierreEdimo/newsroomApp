import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/screens/comment_screen.dart';

Widget commentIcon(Article article, BuildContext context){
  return TextButton.icon(
    onPressed: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            CommentScreen(articleId: article.id),
      ),
    ),
    icon: Icon(Icons.comment_outlined),
    label: Text("(${article.commentCount})"),
  );
}