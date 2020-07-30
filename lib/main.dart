import 'package:Newsroom/UI/Login.dart';
import 'package:Newsroom/UI/Profile.dart';
import 'package:Newsroom/UI/ForumPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'UI/ArticleList.dart';
import 'UI/Theme.dart';

final storage = FlutterSecureStorage();
void displayDialog(context, title, text) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        content: Text(
          text,
          style: TextStyle(fontSize: 14.0),
        ),
      ),
    );

class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;

  CustomAppBar({@required this.child, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: child,
      color: Colors.white,
    );
  }
}

void showCommentModalSheet(String authorId, BuildContext context) async {
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
                    title: Text('Edit Comment',
                        style: TextStyle(color: Colors.black)),
                  ),
                  ListTile(
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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<String> get jwtOrEmpty async {
    String token = await storage.read(key: "jwt");
    if (token == null) return "";
    return token;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'newsroom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Monserrat', scaffoldBackgroundColor: Colors.white),
      home: FutureBuilder(
        future: jwtOrEmpty,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          if (snapshot.data == "") {
            return Auth();
          } else {
            return BottomNavigation();
          }
        },
      ),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key key}) : super(key: key);
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final _widgetOptions = <Widget>[
    new ListArticlePage(),
    new ThemePage(),
    new ForumPage(),
    new ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt((_selectedIndex)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.rss, size: 18),
              title: Text("NewsFeed")),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.compass, size: 18),
              title: Text("Favorites")),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.penSquare, size: 18),
              title: Text("Forum")),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user, size: 18),
              title: Text("My Profile"))
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.red.shade600,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0.0,
      ),
    );
  }
}
