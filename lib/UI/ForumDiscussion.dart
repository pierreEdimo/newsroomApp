import 'package:Newsroom/Model/ForumModel.dart';
import 'package:Newsroom/Service/CommentService.dart';
import 'package:Newsroom/UI/AddCommentForum.dart';
import 'package:Newsroom/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Newsroom/Model/CommentsModel.dart';

import 'CommentDetail.dart';

class ForumDiscussion extends StatefulWidget {
  final GetForum forum;

  ForumDiscussion({@required this.forum});
  @override
  _ForumDiscussionState createState() => _ForumDiscussionState(forum: forum);
}

class _ForumDiscussionState extends State<ForumDiscussion> {
  GetForum forum;
  List<GetCommentModel> comments = List();
  List<GetCommentModel> filterComments = List();
  CommentService _commentService = CommentService();

  _ForumDiscussionState({@required this.forum});

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  void _fetchComments() async {
    _commentService.getComments().then((value) {
      setState(() {
        comments = value;
        filterComments =
            comments.where((u) => (u.forumId) == forum.id).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 260,
        child: Container(
          padding: EdgeInsets.only(top: 38.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10.0),
                color: Colors.black,
                height: 70,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.arrowLeft,
                        size: 18,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Text(
                      "Comments",
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: Colors.white,
                          fontSize: 18),
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.ellipsisV,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(20.0),
                height: 150,
                transform: Matrix4.translationValues(0.0, -15.0, 0.0),
                child: Text(
                  forum.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                      color: Colors.black),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                ),
              )
            ],
          ),
        ),
      ),
      body: filterComments.isEmpty
          ? Center(
              child: Text("No Comments"),
            )
          : Builder(
              builder: (BuildContext context) {
                return ListView(
                    children: filterComments
                        .map(
                          (GetCommentModel comment) => Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS5LGSA_ar1nJAEJYCVNxoW77y4z-HGl0Yfug&usqp=CAU"),
                                  ),
                                  title: Text(
                                    comment.author.userName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  subtitle: Text(
                                    comment.author.profession,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  trailing: IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.ellipsisV,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => CommentDetail(
                                              commentId: comment.id,
                                              commentContent: comment.content,
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 20.0),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            comment.content,
                                            style: TextStyle(fontSize: 13.0),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20.0,
                                            bottom: 20.0),
                                        child: Text(
                                          "0 Answers".toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade600),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList());
              },
            ),
      floatingActionButton: new FloatingActionButton.extended(
        backgroundColor: Colors.red.shade600,
        label: Text("write a comment"),
        icon: FaIcon(FontAwesomeIcons.pen, size: 18),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => AddCommentForum(forumId: forum.id)))
            .then((_) => _fetchComments()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
