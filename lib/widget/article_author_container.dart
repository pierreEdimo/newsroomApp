import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/utilities/constants.dart';

Widget articleAuthor(Article article) {
  return Text(
    "${article.author!.name!}",
    style: nameAndDateStyle,
  );
}
