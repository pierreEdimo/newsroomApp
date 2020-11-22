import 'package:Newsroom/Component/Custom.Title.dart';
import 'package:Newsroom/Model/UserModel.dart';
import 'package:Newsroom/Service/AuthService.dart';
import 'package:Newsroom/UI/Login.dart';
import 'package:Newsroom/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService _authService = AuthService();
  Future<UserModel> user;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  _fetchUser() {
    user = _authService.fethSingleUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Container(
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    listTitle("Settings", 22.0),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () => _showModalSheet(),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserModel singleUser = snapshot.data;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 60,
                        child: listTitle("Hi, ${singleUser.userName}", 18.0),
                      ),
                    ],
                  );
                }

                return Text("");
              },
            ),
          ],
        ),
      ),
    );
  }

  void logout(BuildContext context) async {
    storage.delete(key: "jwt");
    storage.delete(key: "userId");
    Navigator.push(context, MaterialPageRoute(builder: (context) => Auth()));
  }

  void _showModalSheet() async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 130,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.pen,
                      color: Colors.black,
                      size: 18,
                    ),
                    title: Text('Edit Profil',
                        style: TextStyle(color: Colors.black)),
                  ),
                  ListTile(
                    onTap: () => logout(context),
                    leading: FaIcon(
                      FontAwesomeIcons.signOutAlt,
                      color: Colors.black,
                      size: 18,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
