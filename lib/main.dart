import 'package:Newsroom/UI/Login.dart';
import 'package:Newsroom/UI/Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'UI/ArticleList.dart';
import 'UI/Theme.dart';

final storage = FlutterSecureStorage();
bool isLoggedInR;

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
      title: 'findadoctor',
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
              icon: FaIcon(
                FontAwesomeIcons.rss,
                size: 18,
              ),
              title: Text("NewsFeed")),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.compass, size: 18),
              title: Text("Favorites")),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user, size: 18),
              title: Text("My Profile"))
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black12,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0.0,
      ),
    );
  }
}
