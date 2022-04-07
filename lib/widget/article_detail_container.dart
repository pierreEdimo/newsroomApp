import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/blur_container.dart';
import 'package:newsroom/widget/bookmark_icon.dart';
import 'package:newsroom/widget/close_icon.dart';
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
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Stack(
                          children: [
                            imageContainer(
                              article,
                              context,
                            ),
                            blur(context, 0.0),
                            Container(
                              padding: horizontalPadding,
                              height: MediaQuery.of(context).size.height * 0.4,
                              alignment: Alignment.bottomCenter,
                              child: titleContainer(
                                article.title!,
                              ),
                            ),
                            AppBar(
                              backgroundColor: Colors.transparent,
                              automaticallyImplyLeading: false,
                              elevation: 0,
                              actions: [closeIcon(context)],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0))),
                        child: Padding(
                          padding: horizontalPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "image from ${article.imageCredits}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 11,
                                ),
                              ),
                              Container(
                                height: 60,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      commentIcon(article, context),
                                      readingTime(),
                                      BookMarkIcon(
                                        inheritedArticle: article,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
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
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
