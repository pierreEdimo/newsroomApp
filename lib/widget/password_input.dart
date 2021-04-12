import 'package:flutter/material.dart';

Widget passwordInput(TextEditingController passwordController) {
  return TextFormField(
    controller: passwordController,
    decoration:
        InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
    obscureText: true,
    keyboardType: TextInputType.visiblePassword,
    validator: (value) {
      value = passwordController.text;
      if (value == null || value.isEmpty) {
        return 'password is required';
      } else if (value.length < 7) {
        return 'password is too weak';
      }
      return null;
    },
  );
}
