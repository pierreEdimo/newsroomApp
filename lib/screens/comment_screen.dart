import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newsroom/screens/add_comment_screen.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:newsroom/widget/display_diagog.dart';
import 'package:newsroom/widget/list_of_comments.dart';
import 'package:newsroom/widget/title_row.dart';

class CommentScreen extends StatelessWidget {
  final int? articleId;
  final box = Hive.box("newsBox");

  CommentScreen({@required this.articleId});

  @override
  Widget build(BuildContext context) {
    String userId = box.get('userId');
    return Scaffold(
      appBar: customAppBar(
        titleRow(
            "Comment",
            IconButton(
              icon: Icon(Icons.close_outlined),
              onPressed: () => Navigator.of(context).pop(),
            ),
            context),
      ),
      body: listOfComments(
        context,
        articleId,
      ),
      floatingActionButton: TextButton(
        onPressed: () => userId.isNotEmpty ? Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddCommentScreen(
              articleId: articleId,
            ),
          ),
        ) : showErrorDialog(context, "Error", unloggedTextError + "to add new Comments"  ) ,
        child: Text(
          "Comment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
