import 'package:flutter/material.dart';
import 'package:newsroom/screens/add_comment_screen.dart';
import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:newsroom/widget/list_of_comments.dart';
import 'package:newsroom/widget/title_row.dart';

class CommentScreen extends StatelessWidget {
  final int? articleId;

  CommentScreen({@required this.articleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        titleRow(
            "Comment",
            IconButton(
              icon: Icon(Icons.close_outlined),
              onPressed: () => Navigator.of(context).pop(),
            ),
            context),
        80.0,
      ),
      body: listOfComments(
        context,
        articleId,
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddCommentScreen(
              articleId: articleId,
            ),
          ),
        ),
        label: Text(
          "Comment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
