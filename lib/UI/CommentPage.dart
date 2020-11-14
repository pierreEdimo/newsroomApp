import 'package:Newsroom/Component/Custom.Title.dart';
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

  List<GetCommentModel> comments = List();
  List<GetCommentModel> filterComments = List();
  CommentService _commentService = CommentService();

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  void _fetchComments() async {
    _commentService.getComments().then((commentFromServer) {
      setState(() {
        comments = commentFromServer;
        filterComments =
            comments.where((u) => (u.articleId) == articleId).toList();
      });
    });
  }

  void showCommentModalSheet(
      String authorId, int id, BuildContext context) async {
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(
              child: Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    listTitle("Comments", 22.0),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Builder(
              builder: (BuildContext context) {
                return filterComments.isEmpty
                    ? Center(
                        child: Text("No Comments"),
                      )
                    : ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0.0),
                        physics: ClampingScrollPhysics(),
                        children: filterComments
                            .map(
                              (GetCommentModel comment) => Container(
                                margin: EdgeInsets.only(bottom: 20.0),
                                padding: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey.shade200,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.8),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS5LGSA_ar1nJAEJYCVNxoW77y4z-HGl0Yfug&usqp=CAU"),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  comment.author.userName,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(comment.author.profession)
                                              ],
                                            )
                                          ],
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.more_vert),
                                          onPressed: () =>
                                              showCommentModalSheet(comment.uid,
                                                  comment.id, context),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      child: Text(
                                        comment.content,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      );
              },
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
