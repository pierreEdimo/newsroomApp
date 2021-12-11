import 'package:newsroom/model/bookmark.dart';
import 'package:newsroom/screens/article_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:newsroom/widget/background_image_container.dart';
import 'package:newsroom/widget/blur_container.dart';
import 'package:newsroom/widget/flexible_title_container.dart';

Widget bookMarkContainer(
  BookMark bookMark,
  context,
) {
  return Card(
    child: Material(
      borderRadius: BorderRadius.circular(5.0),
      elevation: 10,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ArticleDetail(
              id: bookMark.articleId,
            ),
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.30,
          child: Container(
            child: Stack(
              children: [
                backgroundImageContainer(
                  bookMark.article!.imageUrl!,
                  context,
                ),
                blur(context),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      flexibleTitle(
                        bookMark.article!.title!,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
