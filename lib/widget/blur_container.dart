import 'package:flutter/material.dart';

Widget blur(context, double? borderRadius) {
  return Container(
    height: MediaQuery.of(context).size.height * 1,
    width: MediaQuery.of(context).size.width * 1,
    decoration: BoxDecoration(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      borderRadius: BorderRadius.circular(borderRadius!),
    ),
  );
}
