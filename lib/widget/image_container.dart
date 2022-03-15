import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';

Widget imageContainer(
  Article article,
  context,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Container(
        margin: EdgeInsets.only(top: 10.0),
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: NetworkImage(article.imageUrl!),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Text(
          "image from ${article.imageCredits}",
          style: TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
            fontSize: 11,
          ),
        ),
      )
    ],
  );
}
