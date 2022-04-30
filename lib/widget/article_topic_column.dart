import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/utilities/constants.dart';



Widget articleTopicRow(Article? article) {
  final color = lightColors[article!.id! % lightColors.length];
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        article.topic!.name!,
        style: TextStyle(
          fontFamily: 'PoppinsBold',
          fontSize: 16.0,
          color: color,
        ),
      ),
      Text(
        article.createdAt!,
        style: TextStyle(
          fontFamily: 'PoppinsBold',
          fontSize: 11,
          color: Colors.white,
        ),
      ),
    ],
  );
}
