import 'package:Newsroom/Model/UserModel.dart';
import 'package:Newsroom/Service/AuthService.dart';
import 'package:Newsroom/Service/CommentService.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';

class UpdateComment extends StatefulWidget {
  final int commentId;
  final String word;

  UpdateComment({@required this.commentId, @required this.word});

  @override
  _UpdateCommentState createState() =>
      _UpdateCommentState(commentId: commentId, word: word);
}

class _UpdateCommentState extends State<UpdateComment> {
  int commentId;
  String word;

  final TextEditingController _contentController = TextEditingController()
    ..text;

  CommentService _commentService = CommentService();

  AuthService _authService = AuthService();

  _UpdateCommentState({@required this.commentId, @required this.word});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
            size: 18,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder(
        future: _authService.fethSingleUser(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            return _buildTextField();
          }
          return Text("");
        },
      ),
      floatingActionButton: new FloatingActionButton.extended(
          backgroundColor: Colors.red.shade600,
          label: Text("post"),
          onPressed: () async {
            var uid = await storage.read(key: "userId");
            String content = _contentController.text;
            var res =
                await _commentService.updateComment(commentId, uid, content);
            if (res == 204) {
              Navigator.of(context).pop();
            }
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
          controller: _contentController..text = word,
          maxLines: maxLines,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: "edit comment",
              fillColor: Colors.white,
              filled: true),
        ),
      ),
    );
  }
}
