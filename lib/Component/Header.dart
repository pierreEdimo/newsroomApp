import 'package:Newsroom/UI/ArticleSearch.dart';
import 'package:flutter/material.dart';

import 'Custom.Title.dart';

Widget header(String title, context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        listTitle(title, 22.0),
        IconButton(
          icon: Icon(Icons.search, color: Colors.black),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ArticleSearch(),
            ),
          ),
        )
      ],
    ),
  );
}
