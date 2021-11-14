import 'package:flutter/material.dart';
import 'package:newsroom/screens/search_screen.dart';
import 'package:newsroom/utilities/constants.dart';

Widget topicSearchInput(context) {
  return SafeArea(
    child: Padding(
      padding: horizontalPadding,
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
