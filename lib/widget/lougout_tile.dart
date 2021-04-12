import 'package:flutter/material.dart';
import 'package:newsroom/screens/sign_in_screen.dart';
import 'package:newsroom/widget/list_tile.dart';

import '../main.dart';

void _logout(context) async {
  storage.delete(key: "jwt");
  storage.delete(key: "userId");
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
      (Route<dynamic> route) => false);
}

Widget logoutTile(context) {
  return InkWell(
    onTap: () => _logout(context),
    child: listTile(
      Icon(Icons.logout),
      "Logout",
    ),
  );
}
