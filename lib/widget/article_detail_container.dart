import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/screens/comment_screen.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/image_container.dart';
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
  _loadTheArticle() {
    setState(() {
      _fetchArticle(widget.id!);
    });
  }

  Future<Article> _fetchArticle(int id) {
    return Provider.of<ArticleService>(context, listen: false).fetchArticle(id);
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
              imageContainer(
                article,
                context,
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
                    TextButton.icon(
                      onPressed: () => Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  CommentScreen(articleId: article.id),
                            ),
                          )
                          .then((value) => _loadTheArticle()),
                      icon: Icon(Icons.comment_outlined),
                      label: Text("(${article.commentCount})"),
                    ),
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
}
