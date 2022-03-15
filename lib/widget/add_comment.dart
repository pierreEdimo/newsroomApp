import 'package:flutter/material.dart';
import 'package:newsroom/model/add_comment.dart';
import 'package:newsroom/service/comment_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/display_dialog.dart';
import 'package:provider/provider.dart';

import '../main.dart';

addComment(TextEditingController controller, int articleId,
    BuildContext context) async {
  var uid = await storage.read(key: "userId");
  if (uid == null) {
    showErrorDialog(context, "Error", unLoggedTextError + "to add a comment ");
  }
  if (controller.text.isNotEmpty) {
    AddComment comment = new AddComment(
      content: controller.text,
      articleId: articleId,
      authorId: uid,
    );
    Provider.of<CommentService>(context, listen: false)
        .addComment(comment)
        .then((_) => controller.text = "");
  }
  DoNothingAction();
}
