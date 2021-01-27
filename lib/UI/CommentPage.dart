import 'package:Newsroom/Component/EmptyArray.dart';
import 'package:Newsroom/Component/HeaderDetail.dart';
import 'package:Newsroom/Model/CommentsModel.dart';
import 'package:Newsroom/Service/CommentService.dart';
import 'package:Newsroom/UI/AddCommentPage.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';
import 'UpdateCommentPage.dart';

class CommentPage extends StatefulWidget {
  final int articleId;

  CommentPage({@required this.articleId});
  @override
  _CommentPageState createState() => _CommentPageState(articleId: articleId);
}

class _CommentPageState extends State<CommentPage> {
  int articleId;
  _CommentPageState({@required this.articleId});

  Future<List<GetCommentModel>> _comments;
  CommentService _commentService = CommentService();

  @override
  void initState() {
    super.initState();
    _comments = _commentService.getComments(articleId);
  }

  Future<void> _fetchComments() async {
    setState(() {
      _comments = _commentService.getComments(articleId);
    });
  }

  void _showCommentModalSheet(
      String authorId, int id, String content, BuildContext context) async {
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
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => UpdateComment(
                                      commentId: id,
                                      word: content,
                                    )))
                            .then((_) => _fetchComments());
                      },
                      leading: FaIcon(
                        FontAwesomeIcons.pen,
                        color: Colors.black,
                        size: 18,
                      ),
                      title: Text('Edit Comment',
                          style: TextStyle(color: Colors.black)),
                    ),
                    ListTile(
                      onTap: () async {
                        await _commentService
                            .deleteComment(id)
                            .then((_) => _fetchComments());
                        Navigator.of(context).pop();
                      },
                      leading: FaIcon(
                        FontAwesomeIcons.trash,
                        color: Colors.black,
                        size: 18,
                      ),
                      title: Text(
                        'Delete Comment',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(
              child: headerDetail("Comments", context),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Container(
                child: FutureBuilder(
                  future: _comments,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<GetCommentModel> comments = snapshot.data;

                      return comments.length < 1
                          ? Center(
                              child: emptyArray(
                                  "No Comments, please add the first comment ! ",
                                  context),
                            )
                          : ListView(
                              padding: EdgeInsets.all(0.0),
                              children: comments
                                  .map(
                                    (GetCommentModel comment) => Container(
                                        margin: EdgeInsets.only(bottom: 20.0),
                                        padding: EdgeInsets.all(15.0),
                                        width: 500,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: Colors.grey.shade100),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      comment.author.userName,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      '21.01.2020',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons
                                                      .more_horiz_outlined),
                                                  onPressed: () =>
                                                      _showCommentModalSheet(
                                                    comment.uid,
                                                    comment.id,
                                                    comment.content,
                                                    context,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(comment.content)
                                          ],
                                        )),
                                  )
                                  .toList(),
                            );
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton.extended(
        backgroundColor: Colors.red.shade600,
        label: Text("write a comment"),
        icon: FaIcon(FontAwesomeIcons.pen, size: 18),
        onPressed: () => Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => AddComment(
                  articleId: articleId,
                ),
              ),
            )
            .then((_) => _fetchComments()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
