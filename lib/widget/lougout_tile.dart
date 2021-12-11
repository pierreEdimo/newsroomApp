import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newsroom/screens/sign_in_screen.dart';
import 'package:newsroom/widget/list_tile.dart';

import '../main.dart';
var box = Hive.box('newsBox');

void _logout(context) async {
  storage.delete(key: "jwt");
  storage.delete(key: "userId");
  box.put('userId', "");
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
      (Route<dynamic> route) => false);
}

Widget logoutTile(context) {
  return InkWell(
    onTap: () => _logout(context),
    child: listTile(
      Icon(Icons.logout, size: 25,),
      "Logout",
    ),
  );
}
