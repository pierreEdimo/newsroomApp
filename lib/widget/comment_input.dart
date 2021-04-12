import 'package:flutter/material.dart';

Widget commentInput(TextEditingController controller, maxLines) {
  return TextFormField(
    controller: controller,
    maxLines: maxLines,
    decoration: InputDecoration(
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      hintText: "Add a comment",
      fillColor: Colors.white,
      filled: true,
    ),
  );
}
