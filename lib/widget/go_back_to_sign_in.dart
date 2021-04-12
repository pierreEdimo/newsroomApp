import 'package:flutter/material.dart';

Widget goBack(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Does not have an account ?'),
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text("Sign In"),
      )
    ],
  );
}
