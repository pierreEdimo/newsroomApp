import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newsroom/widget/close_icon.dart';
import 'package:newsroom/widget/list_of_comments.dart';

class CommentScreen extends StatelessWidget {
  final int? articleId;
  final box = Hive.box("newsBox");

  CommentScreen({@required this.articleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Comment',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          closeIcon(context)
        ],
      ),
      body: listOfComments(
        context,
        articleId,
      ),
    );
  }
}
