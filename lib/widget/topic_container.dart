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
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(topic.imageUrl!),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          blur(context, 10.0),
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(
              topic.name!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'PoppinsBold',
                fontSize: 18.0
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
