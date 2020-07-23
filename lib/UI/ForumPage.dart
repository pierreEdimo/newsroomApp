import 'package:Newsroom/Model/ForumModel.dart';
import 'package:Newsroom/Service/AuthService.dart';
import 'package:Newsroom/Service/ForumService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';
import 'AddForumPage.dart';
import 'ForumDiscussion.dart';

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final ForumService _forumService = ForumService();
  final AuthService _authService = AuthService();

  List<GetForum> forums = List();

  @override
  void initState() {
    _authService.fethSingleUser();
    super.initState();
    _fetchPosts();
  }

  _fetchPosts() async {
    _forumService.getForums().then((value) {
      setState(() {
        forums = value;
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
      appBar: AppBar(
        leading: Image.asset('image/icon.png'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Forum",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'),
        ),
        actions: <Widget>[
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.search,
              color: Colors.black,
              size: 18,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        if (forums.isNotEmpty) {
          return ListView.builder(
            itemCount: forums.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(230, 230, 230, 0.3),
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS5LGSA_ar1nJAEJYCVNxoW77y4z-HGl0Yfug&usqp=CAU"),
                          ),
                          title: Text(
                            forums[index].author.userName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            forums[index].author.profession,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.ellipsisV,
                              color: Colors.black,
                              size: 18,
                            ),
                            onPressed: () => _showModalSheet(forums[index].uid),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        InkWell(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ForumDiscussion(
                                        forum: forums[index],
                                      ))),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20.0),
                            child: Text(
                              forums[index].title,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 20.0),
                          child: Text(
                            "0 Comments".toUpperCase(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade600),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
      floatingActionButton: new FloatingActionButton.extended(
        backgroundColor: Colors.red.shade600,
        label: Text("Start a discussion"),
        icon: FaIcon(
          FontAwesomeIcons.penSquare,
          size: 18,
        ),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddForumPage()))
            .then((_) => _fetchPosts()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
