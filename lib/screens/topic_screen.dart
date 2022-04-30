import 'package:flutter/material.dart';
import 'package:newsroom/widget/grid_of_topics.dart';
import 'package:newsroom/widget/standard_app_bar.dart';

class TopicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(
        title: "Topic",
      ),
      body: gridOfTopics(context),
    );
  }
}
