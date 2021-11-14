import 'package:newsroom/model/article.dart';
import 'package:newsroom/screens/article_detail_screen.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:newsroom/widget/background_image_container.dart';
import 'package:newsroom/widget/article_row_container.dart';
import 'package:newsroom/widget/blur_container.dart';
import 'package:newsroom/widget/flexible_title_container.dart';

Widget articleContainer(
  Article article,
  context,
) {
  return Card(
    child: Material(
      borderRadius: BorderRadius.circular(5.0),
      elevation: 10,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ArticleDetail(id: article.id),
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.28,
          child: Container(
            child: Stack(children: [
              backgroundImageContainer(
                article.imageUrl!,
                context,
              ),
              blur(context),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    flexibleTitle(article.title!),
                    verticalSpace,
                    articleRow(article),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    ),
  );
}
