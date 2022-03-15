import 'package:flutter/material.dart';

Widget backgroundImageContainer(
  String imageUrl,
  context,
) {
  return Container(
    width: MediaQuery.of(context).size.width * 1,
    height: MediaQuery.of(context).size.height * 1,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
    ),
  );
}
