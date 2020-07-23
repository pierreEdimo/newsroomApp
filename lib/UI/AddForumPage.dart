import 'package:Newsroom/Model/ForumModel.dart';
import 'package:Newsroom/Service/ForumService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Newsroom/Service/AuthService.dart';
import 'package:Newsroom/Model/UserModel.dart';

import '../main.dart';

class AddForumPage extends StatefulWidget {
  @override
  _AddForumPageState createState() => _AddForumPageState();
}

class _AddForumPageState extends State<AddForumPage> {
  final TextEditingController _contentController = TextEditingController();
  AuthService _authService = AuthService();
  ForumService _forumService = ForumService();
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
            AddForum forum = AddForum(uid: uid, title: _contentController.text);

            var res = await _forumService.addForum(forum);
            if (res == 201) {
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
              hintText: "Add a topic",
              fillColor: Colors.white,
              filled: true),
        ),
      ),
    );
  }
}
