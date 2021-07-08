import 'package:flutter/material.dart';

Widget commentInput(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    maxLines: null,
    minLines: 4,
    decoration: InputDecoration(
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      hintText: "Add a comment",
      filled: true,
    ),
  );
}
