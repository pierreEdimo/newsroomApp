import 'package:flutter/material.dart';

final passWordRex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!?@#\$&*~]).{6,}$');

Widget passwordInput(
    TextEditingController passwordController, String password) {
  return TextFormField(
    controller: passwordController,
    decoration:
        InputDecoration(labelText: password, border: OutlineInputBorder()),
    obscureText: true,
    keyboardType: TextInputType.visiblePassword,
    validator: (value) {
      value = passwordController.text;
      if (value.isEmpty) {
        return 'password is required';
      }
      if (!passWordRex.hasMatch(value)) {
        return 'invalid password';
      }
      return null;
    },
  );
}
