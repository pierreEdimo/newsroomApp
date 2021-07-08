import 'package:flutter/material.dart';
import 'package:newsroom/screens/search_screen.dart';

import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:newsroom/widget/grid_of_topics.dart';
import 'package:newsroom/widget/title_row.dart';

class TopicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        titleRow(
            "Topic",
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              ),
            ),
            context),
        80.0,
      ),
      body: gridofTopics(context),
    );
  }
}
