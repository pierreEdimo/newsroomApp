import 'package:flutter/material.dart';
import 'package:newsroom/widget/grid_of_topics.dart';
import 'package:newsroom/widget/search_icon.dart';

class TopicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Topic",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          searchIcon(context),
        ],
      ),
      body: gridOfTopics(context),
    );
  }
}
