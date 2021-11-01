import 'package:flutter/material.dart';
import 'package:newsroom/main.dart';
import 'package:newsroom/model/add_comment.dart';
import 'package:newsroom/service/comment_service.dart';
import 'package:newsroom/widget/comment_input.dart';
import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:provider/provider.dart';

class AddCommentScreen extends StatelessWidget {
  final int? articleId;

  AddCommentScreen({@required this.articleId});

  final maxLines = 26;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          SafeArea(
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
          80.0),
      floatingActionButton: TextButton(
        onPressed: () async {
          var uid = await storage.read(key: "userId");
          if (_controller.text.isNotEmpty) {
            AddComment comment = new AddComment(
              content: _controller.text,
              articleId: articleId,
              authorId: uid,
            );
            Provider.of<CommentService>(context, listen: false)
                .addComment(comment)
                .then((_) => _controller.text = "")
                .then(
                  (_) => Navigator.of(context).pop(),
                );
          }
          DoNothingAction();
        },
        child: Text(
          "Post",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: 30.0,
          left: 30.0,
          top: 15.0,
          bottom: 15.0,
        ),
        child: Container(
          height: maxLines * 24.0,
          child: commentInput(_controller),
        ),
      ),
    );
  }
}
