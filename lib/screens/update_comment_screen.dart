import 'package:flutter/material.dart';
import 'package:newsroom/model/add_comment.dart';
import 'package:newsroom/model/comment.dart';
import 'package:newsroom/service/comment_service.dart';
import 'package:newsroom/widget/comment_input.dart';
import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class UpdateCommentScreen extends StatelessWidget {
  final Comment comment;

  UpdateCommentScreen({@required this.comment});

  final maxLines = 26;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = comment.content;
    return Scaffold(
      appBar: CustomAppBar(
        height: 100,
        child: SafeArea(
          child: Center(
            child: Container(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: IconButton(
                  icon: Icon(Icons.close_outlined),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onPressed: () async {
          var uid = await storage.read(key: "userId");
          if (_controller.text.isNotEmpty) {
            AddComment addComment = new AddComment(
              content: _controller.text,
              articleId: comment.articleId,
              authorId: uid,
            );
            Provider.of<CommentService>(context, listen: false)
                .updateComment(
                  addComment,
                  comment.id,
                )
                .then((_) => _controller.text = "")
                .then(
                  (_) => Navigator.of(context).pop(),
                );
          }
          DoNothingAction();
        },
        label: Text(
          "edit",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: EdgeInsets.only(
          right: 25.0,
          left: 25.0,
          top: 10.0,
          bottom: 10.0,
        ),
        child: Container(
          height: maxLines * 24.0,
          child: commentInput(_controller, maxLines),
        ),
      ),
    );
  }
}
