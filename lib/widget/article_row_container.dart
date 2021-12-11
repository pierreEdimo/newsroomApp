import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/utilities/constants.dart';

Widget articleRow(Article article) {
  return Text(
    "${article.author!.name!} . ${article.createdAt!}",
    style: nameAndDateStyle,
  );
}
