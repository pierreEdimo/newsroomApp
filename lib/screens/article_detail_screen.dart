import 'package:flutter/material.dart';
import 'package:newsroom/widget/article_detail_container.dart';
import 'package:newsroom/widget/close_icon.dart';

class ArticleDetail extends StatelessWidget {
  final int? id;

  ArticleDetail({@required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          closeIcon(context)
        ],
      ),
      body: ArticleDetailContainer(
        id: id!,
      ),
    );
  }
}
