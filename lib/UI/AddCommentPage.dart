import 'package:Newsroom/Model/CommentsModel.dart';
import 'package:Newsroom/Model/UserModel.dart';
import 'package:Newsroom/Service/AuthService.dart';
import 'package:Newsroom/Service/CommentService.dart';

import 'package:flutter/material.dart';

import '../main.dart';

class AddComment extends StatefulWidget {
  final articleId;

  AddComment({@required this.articleId});

  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final TextEditingController _contentController = TextEditingController();

  CommentService _commentService = CommentService();

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 15.0),
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _authService.fethSingleUser(),
              builder:
                  (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
                if (snapshot.hasData) {
                  return _buildTextField();
                }
                return Text("");
              },
            ),
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton.extended(
          backgroundColor: Colors.red.shade600,
          label: Text("post"),
          onPressed: () async {
            var uid = await storage.read(key: "userId");
            AddCommentModel comment = AddCommentModel(
                articleId: widget.articleId,
                uid: uid,
                content: _contentController.text);
            await _commentService.comment(comment);
            Navigator.of(context).pop();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTextField() {
    final maxLines = 26;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: maxLines * 24.0,
        child: TextField(
          controller: _contentController,
          maxLines: maxLines,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: "Add a comment",
              fillColor: Colors.white,
              filled: true),
        ),
      ),
    );
  }
}
