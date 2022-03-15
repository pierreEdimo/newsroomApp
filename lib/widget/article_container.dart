import 'package:newsroom/model/article.dart';
import 'package:newsroom/screens/article_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/article_topic_column.dart';
import 'package:newsroom/widget/background_image_container.dart';
import 'package:newsroom/widget/article_author_container.dart';
import 'package:newsroom/widget/blur_container.dart';
import 'package:newsroom/widget/flexible_title_container.dart';

Widget articleContainer(
  Article article,
  context,
) {
  return InkWell(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ArticleDetail(id: article.id!),
      ),
    ),
    child: Container(
      margin: verticalMargin,
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.40,
      child: Container(
        child: Stack(children: [
          backgroundImageContainer(
            article.imageUrl!,
            context,
          ),
          blur(context),
          Container(
            padding: all10Padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                flexibleTitle(article.title!),
                vertical5Space,
                articleTopicRow(article),
              ],
            ),
          ),
          Container(
            padding: all10Padding,
            child: articleAuthor(article),
          )
        ]),
      ),
    ),
  );
}
