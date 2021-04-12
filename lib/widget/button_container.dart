import 'package:flutter/material.dart';

Widget buttonContainer(
  int numbOfComment,
  context,
) {
  return Container(
    padding: EdgeInsets.all(20.0),
    width: MediaQuery.of(context).size.width * 1,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Center(
      child: Text(
        "($numbOfComment) Commtent(s)",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
