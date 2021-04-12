import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

Widget textContainer(String content) {
  return Markdown(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    padding: EdgeInsets.all(0.0),
    data: content,
    styleSheet: MarkdownStyleSheet(
      p: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
  );
}
