import 'package:flutter/material.dart';

final passWordRex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!?@#\$&*~]).{6,}$');

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
      }
      if (!passWordRex.hasMatch(value)) {
        return 'invalid password';
      }
      return null;
    },
  );
}
