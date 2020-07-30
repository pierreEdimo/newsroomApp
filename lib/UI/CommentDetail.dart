import 'package:Newsroom/Model/Answer.dart';
import 'package:Newsroom/Service/CommentService.dart';
import 'package:Newsroom/UI/AnswerComment.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';

class CommentDetail extends StatefulWidget {
  final String commentContent;
  final int commentId;

  CommentDetail({@required this.commentContent, @required this.commentId});

  @override
  _CommentDetailState createState() =>
      _CommentDetailState(commentId: commentId, commentContent: commentContent);
}

class _CommentDetailState extends State<CommentDetail> {
  String commentContent;
  int commentId;
  final CommentService _commentService = CommentService();
  List<GetAnsWer> answers = List();
  List<GetAnsWer> filterAnswers = List();

  _CommentDetailState(
      {@required this.commentId, @required this.commentContent});

  @override
  void initState() {
    super.initState();
    _fetchAnswers();
  }

  void _fetchAnswers() async {
    _commentService.fetchAnswers().then((value) {
      setState(() {
        answers = value;
        filterAnswers =
            answers.where((u) => (u.commentId) == commentId).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void _showModalSheet(String authorId) async {
      String userId = await storage.read(key: "userId");
      showModalBottomSheet(
          context: context,
          builder: (context) {
            if (authorId == userId) {
              return Container(
                color: Color(0xFF737373),
                height: 130,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: FaIcon(
                          FontAwesomeIcons.pen,
                          color: Colors.black,
                          size: 18,
                        ),
                        title: Text('Edit Post',
                            style: TextStyle(color: Colors.black)),
                      ),
                      ListTile(
                        leading: FaIcon(
                          FontAwesomeIcons.trash,
                          color: Colors.black,
                          size: 18,
                        ),
                        title: Text(
                          'Delete Post',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                color: Color(0xFF737373),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.flag,
                      color: Colors.black,
                      size: 18,
                    ),
                    title: Text("Report"),
                  ),
                ),
              );
            }
          });
    }

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
                      "Answers",
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
                  commentContent,
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
      body: filterAnswers.isEmpty
          ? Center(
              child: Text("No Answers"),
            )
          : Builder(
              builder: (BuildContext context) {
                return ListView(
                    children: filterAnswers
                        .map((GetAnsWer answer) => Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS5LGSA_ar1nJAEJYCVNxoW77y4z-HGl0Yfug&usqp=CAU"),
                                    ),
                                    title: Text(
                                      answer.author.userName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    subtitle: Text(
                                      answer.author.profession,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: IconButton(
                                      icon: FaIcon(
                                        FontAwesomeIcons.ellipsisV,
                                        size: 18,
                                        color: Colors.black,
                                      ),
                                      onPressed: () =>
                                          _showModalSheet(answer.uid),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 20.0, left: 20.0, bottom: 20.0),
                                    child: Text(
                                      answer.content,
                                      style: TextStyle(fontSize: 13.0),
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList());
              },
            ),
      floatingActionButton: new FloatingActionButton.extended(
        backgroundColor: Colors.red.shade600,
        label: Text("Reply"),
        icon: FaIcon(
          FontAwesomeIcons.penSquare,
          size: 18,
        ),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => AnsWerComment(commentId: commentId)))
            .then((_) => _fetchAnswers()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
