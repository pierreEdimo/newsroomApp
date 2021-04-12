import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

Widget inforMationContainer(String data) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25.0,
        bottom: 10.0,
      ),
      child: Markdown(
        padding: EdgeInsets.all(0.0),
        data: data,
      ),
    ),
  );
}
