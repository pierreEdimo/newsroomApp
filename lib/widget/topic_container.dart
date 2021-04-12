import 'package:flutter/material.dart';
import 'package:newsroom/model/topic.dart';
import 'package:newsroom/screens/article_from_topic.dart';
import 'package:newsroom/widget/blur_container.dart';

Widget topicContainer(Topic topic, context) {
  return InkWell(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ArticleFromTopic(
          topicId: topic.id,
          topicName: topic.name,
        ),
      ),
    ),
    child: Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          image: DecorationImage(
            image: NetworkImage(topic.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            blur(context),
            Center(
              child: Text(
                topic.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'OpenSansBold',
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
