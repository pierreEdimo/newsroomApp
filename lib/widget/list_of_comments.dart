import 'package:flutter/material.dart';
import 'package:newsroom/model/comment.dart';
import 'package:newsroom/service/comment_service.dart';
import 'package:newsroom/widget/comment_container.dart';
import 'package:provider/provider.dart';

Future<void> _fetchComments(
  context,
  articleId,
) async {
  return await Provider.of<CommentService>(context, listen: false)
      .fetchComments(articleId);
}

Widget listOfComments(
  context,
  articleId,
) {
  return FutureBuilder(
    future: Provider.of<CommentService>(context).fetchComments(articleId),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<Comment> comments = snapshot.data;

        return comments.length < 1
            ? Center(
                child: Text(
                  "No comments, please be the first",
                  textAlign: TextAlign.center,
                ),
              )
            : RefreshIndicator(
                onRefresh: () => _fetchComments(
                  context,
                  articleId,
                ),
                child: ListView(
                  padding: EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                  ),
                  children: comments
                      .map(
                        (Comment comment) => Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: commentContainer(
                            comment,
                            context,
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
