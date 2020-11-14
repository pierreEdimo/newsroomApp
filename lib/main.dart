import 'package:Newsroom/Service/AuthService.dart';
import 'package:Newsroom/UI/FavoriteScreen.dart';
import 'package:Newsroom/UI/Login.dart';

import 'package:Newsroom/UI/Profile.dart';
import 'package:Newsroom/UI/SearchPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'UI/ArticleScreen.dart';

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
  final AuthService _authService = AuthService();
  int _selectedIndex = 0;

  final _widgetOptions = <Widget>[
    new ArticleSreen(),
    new SearchPage(),
    new FavoriteScreen(),
    new ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
    _authService.fethSingleUser();
  }

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
              icon: Icon(Icons.rss_feed), title: Text("NewsFeed")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Search")),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border), title: Text("BookMark")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), title: Text("My Profile"))
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red.shade600,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
