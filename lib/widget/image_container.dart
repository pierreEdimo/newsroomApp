import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';

Widget imageContainer(
  Article article,
  context,
) {
  return Container(
    width: MediaQuery.of(context).size.width * 1,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(article.imageUrl!),
        fit: BoxFit.cover,
      ),
    ),
  );
}
