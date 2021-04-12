import 'package:flutter/material.dart';
import 'package:newsroom/screens/sign_up_screen.dart';

Widget goToSignUp(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Does not have an account ?'),
      TextButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SignUpScreen(),
          ),
        ),
        child: Text("Sign Up"),
      )
    ],
  );
}
