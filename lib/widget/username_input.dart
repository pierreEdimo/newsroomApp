import 'package:flutter/material.dart';

Widget userNameInput(TextEditingController userNameController) {
  return TextFormField(
    controller: userNameController,
    decoration:
        InputDecoration(labelText: 'Usermame', border: OutlineInputBorder()),
    keyboardType: TextInputType.text,
    validator: (value) {
      value = userNameController.text;
      if (value.isEmpty) {
        return 'userName is required';
      }
      return null;
    },
  );
}
