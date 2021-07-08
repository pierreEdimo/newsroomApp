import 'package:newsroom/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:newsroom/screens/profile_screen.dart';
import 'package:newsroom/screens/topic_screen.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key? key}) : super(key: key);
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final _widgetOptions = <Widget>[
    HomeScreen(),
    TopicScreen(),
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
            icon: Icon(Icons.rss_feed),
            label: "feeds",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category_outlined,
              ),
              label: "topics"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "user",
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red.shade600,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
