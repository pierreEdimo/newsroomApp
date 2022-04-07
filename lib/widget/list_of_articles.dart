import 'package:newsroom/model/article.dart';
import 'package:flutter/material.dart';
import 'package:newsroom/utilities/constants.dart';
import 'article_container.dart';

class ListOfArticles extends StatelessWidget {
  final List<Article>? articles;
  final String? msg;
  final bool? shrinkwrap;
  final Widget? child;

  const ListOfArticles({
    Key? key,
    this.articles,
    this.msg,
    this.shrinkwrap,
    this.child,
  }) : super(key: key);

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
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              child == null ? Container() : child!,
              ListView(
                padding: horizontalPadding,
                shrinkWrap: shrinkwrap == null ? false : shrinkwrap!,
                physics: ClampingScrollPhysics(),
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
              ),
            ],
          );
  }
}
