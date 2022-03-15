import 'package:flutter/material.dart';
import 'package:newsroom/model/add_comment.dart';
import 'package:newsroom/model/comment.dart';
import 'package:newsroom/service/comment_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/close_icon.dart';
import 'package:newsroom/widget/comment_input.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class UpdateCommentScreen extends StatelessWidget {
  final Comment? comment;

  UpdateCommentScreen({@required this.comment});

  final maxLines = 26;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = comment!.content!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Edit Comment",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [closeIcon(context)],
      ),
      floatingActionButton: TextButton(
        child: Text(
          "edit",
          style:
              TextStyle(fontFamily: 'OpenSanBold', fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          var uid = await storage.read(key: "userId");
          if (_controller.text.isNotEmpty) {
            AddComment addComment = new AddComment(
              content: _controller.text,
              articleId: comment!.articleId,
              authorId: uid,
            );
            Provider.of<CommentService>(context, listen: false)
                .updateComment(
                  addComment,
                  comment!.id!,
                )
                .then((_) => _controller.text = "")
                .then(
                  (_) => Navigator.of(context).pop(),
                );
          }
          DoNothingAction();
        },
      ),
      body: Padding(
        padding: standardPadding,
        child: Container(
          height: maxLines * 24.0,
          child: commentInput(_controller),
        ),
      ),
    );
  }
}
