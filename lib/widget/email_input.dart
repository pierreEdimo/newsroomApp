import 'package:flutter/material.dart';

Widget emailInput(TextEditingController emailController, String placeholder) {
  return TextFormField(
    controller: emailController,
    decoration:
        InputDecoration(labelText: placeholder, border: OutlineInputBorder()),
    keyboardType: TextInputType.emailAddress,
    validator: (value) {
      value = emailController.text;
      if (value.isEmpty) {
        return 'email is required';
      } else if (!value.contains('@')) {
        return 'please enter a valid email';
      }
      return null;
    },
  );
}
