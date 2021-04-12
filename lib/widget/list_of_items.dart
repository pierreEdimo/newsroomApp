import 'package:flutter/material.dart';
import 'package:newsroom/model/userModel.dart';
import 'package:newsroom/service/auth_service.dart';
import 'package:newsroom/widget/about_tile.dart';
import 'package:newsroom/widget/bookmark_tile.dart';
import 'package:newsroom/widget/contact_tile.dart';
import 'package:newsroom/widget/email_tile.dart';
import 'package:newsroom/widget/lougout_tile.dart';
import 'package:provider/provider.dart';

Widget listOfItem(context) {
  return FutureBuilder(
    future: Provider.of<AuthService>(context).fethSingleUser(),
    builder: (context, snapshot) {
      if (snapshot.hasError)
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Center(
            child: Text(
              "Error , please try again later",
              textAlign: TextAlign.center,
            ),
          ),
        );
      if (snapshot.hasData) {
        UserModel user = snapshot.data;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            emailTile(user.email, context),
            bookMarkTile(context),
            contactTile(context),
            aboutTile(context),
            logoutTile(context),
          ],
        );
      }
      return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}
