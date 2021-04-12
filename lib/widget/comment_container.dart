import 'package:flutter/material.dart';
import 'package:newsroom/model/comment.dart';
import 'package:newsroom/widget/comment_modal.dart';

Widget commentContainer(
  Comment comment,
  context,
) {
  return Card(
    elevation: 3.0,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "${comment.author.userName}",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      "${comment.createdAt}",
                      style: TextStyle(fontSize: 11.0),
                    )
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.more_vert_outlined),
                  onPressed: () => commentModal(
                    comment.authorId,
                    context,
                    comment,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Text("${comment.content}")
          ],
        ),
      ),
    ),
  );
}
