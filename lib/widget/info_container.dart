import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:newsroom/utilities/constants.dart';

Widget informationContainer(String data) {
  return Container(
    child: Padding(
      padding: completePadding,
      child: Markdown(
        padding: EdgeInsets.all(0.0),
        data: data,
      ),
    ),
  );
}
