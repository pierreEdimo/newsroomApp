import 'package:flutter/material.dart';
import 'package:newsroom/model/topic.dart';
import 'package:newsroom/service/topic_service.dart';
import 'package:newsroom/widget/topic_container.dart';
import 'package:provider/provider.dart';

Future<List<Topic>> _fecthTopics(context) async {
  return await Provider.of<TopicService>(context, listen: false).fetchTopics();
}

Widget gridofTopics(context) {
  return FutureBuilder(
    future: Provider.of<TopicService>(context).fetchTopics(),
    builder: (context, AsyncSnapshot<List<Topic>> snapshot) {
      if (snapshot.hasError)
        return Center(
          child: Text(
            "Error , please try again later",
            textAlign: TextAlign.center,
          ),
        );
      if (snapshot.hasData) {
        List<Topic> topics = snapshot.data!;

        return RefreshIndicator(
          onRefresh: () => _fecthTopics(context),
          child: GridView.count(
            padding: EdgeInsets.only(
              left: 25.0,
              right: 25.0,
            ),
            crossAxisCount: 2,
            children: topics
                .map(
                  (Topic topic) => topicContainer(
                    topic,
                    context,
                  ),
                )
                .toList(),
          ),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
