import 'package:findadoctor/Model/UserModel.dart';
import 'package:findadoctor/Service/AuthService.dart';
import 'package:findadoctor/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  final AuthService _authService = new AuthService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authService.fethSingleUser(),
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasData) {
          UserModel user = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              leading: Image.asset('image/icon.png'),
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                user.userName,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans'),
              ),
              actions: <Widget>[
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.cog,
                    color: Colors.black,
                    size: 18,
                  ),
                  onPressed: () => showModal(context),
                )
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  void logout(BuildContext context) async {
    storage.delete(key: "jwt");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BottomNavigation()));
  }

  void showModal(BuildContext context) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 150.0,
        width: 70.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () => print("Hello World"),
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.pen,
                      size: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Edit profil")
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => logout(context),
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.signOutAlt,
                      size: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Signout")
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.windowClose,
                      size: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Cancel")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }
}
