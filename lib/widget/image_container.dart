import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/widget/snack_bar_page.dart';

Widget imageContainer(
  Article article,
  context,
) {
  return SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(article.imageUrl!),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(
              left: 25.0,
              right: 25.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                SnackBarPage(
                  article: article,
                )
              ],
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
    ),
  );
}
