import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/utilities/constants.dart';

Widget articleAuthor(Article article) {
  return Row(
    children: [
      Text(
        "😎",
        style: TextStyle(fontSize: 20.0),
      ),
      SizedBox(
        width: 5.0,
      ),
      Text(
        "${article.author!.name!}",
        style: authorNameStyle,
      )
    ],
  );
}
