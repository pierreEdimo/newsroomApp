import 'package:newsroom/model/article.dart';
import 'package:flutter/material.dart';
import 'package:newsroom/utilities/constants.dart';
import 'article_container.dart';

class ListOfArticles extends StatelessWidget {
  final List<Article>? articles;
  final String? msg;

  const ListOfArticles({Key? key, this.articles, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return articles!.length < 1
        ? Container(
            padding: horizontalPadding,
            child: Center(
              child: Text(
                msg!,
                textAlign: TextAlign.center,
              ),
            ),
          )
        : ListView(
            padding: horizontal15Padding,
            children: articles!
                .map(
                  (Article article) => Container(
                    child: articleContainer(
                      article,
                      context,
                    ),
                  ),
                )
                .toList(),
          );
  }
}
