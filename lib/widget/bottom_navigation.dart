import 'package:newsroom/screens/bookmark_screen.dart';
import 'package:newsroom/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:newsroom/screens/pod_cast_screen.dart';
import 'package:newsroom/screens/profile_screen.dart';
import 'package:newsroom/screens/topic_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsroom/service/theme_service.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _widgetOptions = <Widget>[
    HomeScreen(),
    PodCastScreen(),
    TopicScreen(),
    BookMarkScreen(),
    ProfileScreen(),
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
              size: 20,
            ),
            label: "feeds",
          ),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.podcast,
                size: 20,
              ),
              label: "podcasts"),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.compass,
              size: 22,
            ),
            label: "topics",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.bookmark,
              size: 20,
            ),
            label: "bookmark",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.user,
              size: 20,
            ),
            label: "user",
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red.shade600,
        unselectedItemColor: Colors.grey.shade600,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
