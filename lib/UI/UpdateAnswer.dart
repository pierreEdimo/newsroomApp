import 'package:Newsroom/Model/UserModel.dart';
import 'package:Newsroom/Service/AuthService.dart';
import 'package:Newsroom/Service/CommentService.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';

class UpdateAnswer extends StatefulWidget {
  final int answerId;

  UpdateAnswer({@required this.answerId});

  @override
  _UpdateAnswerState createState() => _UpdateAnswerState(answerId: answerId);
}

class _UpdateAnswerState extends State<UpdateAnswer> {
  final TextEditingController _contentController = TextEditingController();
  int answerId;

  CommentService _commentService = CommentService();

  AuthService _authService = AuthService();

  _UpdateAnswerState({@required this.answerId});

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
                await _commentService.updateAnswer(answerId, uid, content);
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
          controller: _contentController,
          maxLines: maxLines,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: "edit answer",
              fillColor: Colors.white,
              filled: true),
        ),
      ),
    );
  }
}
