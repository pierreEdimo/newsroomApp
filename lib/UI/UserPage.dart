import 'package:findadoctor/UI/Profile.dart';
import 'package:findadoctor/UI/unloggedPage.dart';
import 'package:findadoctor/main.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String token;

  getjwt() async {
    token = await storage.read(key: "jwt");
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getjwt(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ProfilePage();
        } else if (snapshot.data == null) {
          return UnloggedPage();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
