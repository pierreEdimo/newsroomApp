import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/screens/comment_screen.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/button_container.dart';
import 'package:newsroom/widget/image_container.dart';
import 'package:newsroom/widget/text_container.dart';
import 'package:newsroom/widget/title_container.dart';
import 'package:provider/provider.dart';

Future<void> _fetchArticle(
  int id,
  context,
) async {
  return await Provider.of<ArticleService>(context, listen: false)
      .fetchArticle(id);
}

Widget articleDetailContainer(int id, context) {
  Future<Article> article =
      Provider.of<ArticleService>(context).fetchArticle(id);
  return FutureBuilder(
    future: article,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        Article article = snapshot.data;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            imageContainer(
              article,
              context,
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  titleContainer(
                    article.title,
                  ),
                  verticalSpace,
                  textContainer(
                    article.content,
                  ),
                  verticalSpace,
                  Text(
                    "By ${article.author.name} , on ${article.createdAt}",
                  ),
                  verticalSpace,
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (context) =>
                                CommentScreen(articleId: article.id),
                          ),
                        )
                        .then(
                          (_) => _fetchArticle(
                            id,
                            context,
                          ),
                        ),
                    child: buttonContainer(
                      article.commentCount,
                      context,
                    ),
                  )
                ],
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
