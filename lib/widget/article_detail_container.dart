import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/bookmark_icon.dart';
import 'package:newsroom/widget/comment_icon.dart';
import 'package:newsroom/widget/image_container.dart';
import 'package:newsroom/widget/reading_time.dart';
import 'package:newsroom/widget/text_container.dart';
import 'package:newsroom/widget/title_container.dart';
import 'package:provider/provider.dart';

class ArticleDetailContainer extends StatefulWidget {
  final int? id;

  const ArticleDetailContainer({Key? key, this.id}) : super(key: key);

  @override
  _ArticleDetailContainerState createState() => _ArticleDetailContainerState();
}

class _ArticleDetailContainerState extends State<ArticleDetailContainer> {
  Future<Article> _fetchArticle(int id) {
    return Provider.of<ArticleService>(context, listen: true).fetchArticle(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchArticle(widget.id!),
      builder: (context, AsyncSnapshot<Article> snapshot) {
        if (snapshot.hasData) {
          Article article = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: horizontalPadding,
                        child: imageContainer(
                          article,
                          context,
                        ),
                      ),
                      Padding(
                        padding: standardPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleContainer(
                              article.title!,
                            ),
                            verticalSpace,
                            Text(
                              "By ${article.author!.name!} , on ${article.createdAt}",
                            ),
                            verticalSpace,
                            textContainer(
                              article.content!,
                            ),
                            verticalSpace,
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                padding: standardPadding,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commentIcon(article, context),
                      readingTime(),
                      BookMarkIcon(
                        inheritedArticle: article,
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
