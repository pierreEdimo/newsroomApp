import 'package:flutter/material.dart';

Widget flexibleTitle(String title) {
  return Flexible(
    child: Text(
      title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 22.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'PoppinsBold'),
    ),
  );
}
