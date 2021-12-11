import 'package:flutter/material.dart';
import 'package:newsroom/screens/sign_in_screen.dart';
import 'package:newsroom/widget/list_tile.dart';

Widget loginTile(BuildContext context) {
  return InkWell(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ),
    ),
    child: listTile(
        Icon(
          Icons.login,
          size: 25,
        ),
        "Login"),
  );
}
