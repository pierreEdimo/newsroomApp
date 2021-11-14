import 'package:flutter/material.dart';
import 'package:newsroom/main.dart';
import 'package:newsroom/model/comment.dart';
import 'package:newsroom/screens/update_comment_screen.dart';
import 'package:newsroom/service/comment_service.dart';
import 'package:provider/provider.dart';

commentModal(String authorId, context, Comment comment) async {
  String? userId = await storage.read(key: "userId");
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return authorId == userId
          ? Container(
              color: Color(0xFF737373),
              child: Container(
                height: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      onTap: () async {
                        await Provider.of<CommentService>(context,
                                listen: false)
                            .deleteComment(comment.id!)
                            .then(
                              (_) => Navigator.of(context).pop(),
                            );
                      },
                      leading: Icon(Icons.delete_outline),
                      title: Text("delete"),
                    ),
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) => UpdateCommentScreen(
                                comment: comment,
                              ),
                            ),
                          )
                          .then(
                            (_) => Navigator.of(context).pop(),
                          ),
                      leading: Icon(Icons.edit_outlined),
                      title: Text("edit"),
                    )
                  ],
                ),
              ),
            )
          : Container(
              child: Container(
                child: ListTile(
                  leading: Icon(
                    Icons.flag_outlined,
                  ),
                  title: Text("Report"),
                ),
              ),
            );
    },
  );
}
