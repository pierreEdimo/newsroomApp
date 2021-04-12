import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/utilities/constants.dart';

Widget articleRow(Article article) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        article.author.name,
        style: textandDateStyle,
      ),
      Text(
        article.createdAt,
        style: textandDateStyle,
      ),
    ],
  );
}
