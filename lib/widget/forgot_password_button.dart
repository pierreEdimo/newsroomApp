import 'package:flutter/material.dart';
import 'package:newsroom/screens/forgot_password_screen.dart';

Widget forgotPassWordButton(BuildContext context) {
  return TextButton(
      onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ForgoPassWordScreen(),
            ),
          ),
      child: Text("Forgot your password ?"));
}
