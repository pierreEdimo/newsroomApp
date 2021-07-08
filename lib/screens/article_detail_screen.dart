import 'package:flutter/material.dart';
import 'package:newsroom/widget/article_detail_container.dart';

class ArticleDetail extends StatelessWidget {
  final int? id;

  ArticleDetail({@required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ArticleDetailContainer(
          id: id!,
        ),
      ),
    );
  }
}
