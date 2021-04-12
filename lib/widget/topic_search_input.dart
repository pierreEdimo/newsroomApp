import 'package:flutter/material.dart';
import 'package:newsroom/screens/search_screen.dart';

Widget topicSearchInput(context) {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: TextField(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SearchScreen(),
          ),
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "search...",
          suffixIcon: Icon(
            Icons.search,
          ),
        ),
      ),
    ),
  );
}
