import 'package:Newsroom/Component/Custom.Tile.dart';
import 'package:Newsroom/Component/Custom.Title.dart';
import 'package:Newsroom/Model/UserModel.dart';
import 'package:Newsroom/Service/AuthService.dart';
import 'package:Newsroom/UI/About.dart';
import 'package:Newsroom/UI/Login.dart';
import 'package:Newsroom/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Newsroom/UI/LicenseScreen.dart';

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

  _sendEmail() async {
    const url = 'mailto:pierredimo@live.com?subject=&body=%20';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(
              child: Container(
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
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: FutureBuilder(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    UserModel singleUser = snapshot.data;

                    return ListView(
                      padding: EdgeInsets.all(0.0),
                      children: [
                        customTile(
                          Icon(
                            Icons.email_outlined,
                            color: Colors.blue.shade400,
                          ),
                          singleUser.email,
                          Icon(Icons.keyboard_arrow_right_outlined),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        listTitle("General Settings", 22.0),
                        SizedBox(height: 20.0),
                        InkWell(
                          onTap: () => _sendEmail(),
                          child: customTile(
                            Icon(
                              Icons.email_outlined,
                              color: Colors.blue.shade400,
                            ),
                            "Contact us",
                            Icon(Icons.keyboard_arrow_right_outlined),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => LicenseScreen())),
                          child: customTile(
                            Icon(
                              Icons.attach_file_outlined,
                              color: Colors.orange.shade400,
                            ),
                            "Licence",
                            Icon(Icons.keyboard_arrow_right_outlined),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AboutScreen(),
                            ),
                          ),
                          child: customTile(
                            Icon(
                              Icons.info_outline_rounded,
                              color: Colors.green.shade400,
                            ),
                            "About us",
                            Icon(Icons.keyboard_arrow_right_outlined),
                          ),
                        )
                      ],
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    storage.delete(key: "jwt");
    storage.delete(key: "userId");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Auth()),
        (Route<dynamic> route) => false);
  }

  void _showModalSheet() async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Container(
                child: ListTile(
                  onTap: () => _logout(context),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.red.shade400,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
