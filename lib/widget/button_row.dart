import 'package:flutter/material.dart';
import 'package:newsroom/screens/comment_screen.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:provider/provider.dart';

Future<void> _fetchArticle(
  int id,
  context,
) async {
  return await Provider.of<ArticleService>(context, listen: false)
      .fetchArticle(id);
}

Widget buttoRow(
  int numbOfComment,
  BuildContext context,
  int id,
) {
  return Row(
    children: [
      TextButton.icon(
        style: TextButton.styleFrom(
          primary: Colors.black,
        ),
        onPressed: () => Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => CommentScreen(articleId: id),
              ),
            )
            .then(
              (_) => _fetchArticle(id, context),
            ),
        icon: Icon(Icons.comment_outlined),
        label: Text("($numbOfComment)"),
      ),
      /**
       *IconButton(onPressed: () => print("shared"), icon: Icon(Icons.share_outlined))
       */
   
      
    ],
  );
}
