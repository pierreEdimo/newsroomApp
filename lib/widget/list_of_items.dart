import 'package:flutter/material.dart';
import 'package:newsroom/model/user_,model.dart';
import 'package:newsroom/service/auth_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/about_tile.dart';
import 'package:newsroom/widget/change_theme.dart';
import 'package:newsroom/widget/contact_tile.dart';
import 'package:newsroom/widget/email_tile.dart';
import 'package:newsroom/widget/log_out_tile.dart';
import 'package:provider/provider.dart';
import 'login_tile.dart';

Widget listOfItem(context) {
  return FutureBuilder(
    future: Provider.of<AuthService>(context).fetchSingleUser(),
    builder: (context, AsyncSnapshot<UserModel> snapshot) {

      if(snapshot.hasError){
          return Container(
            padding: completePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                loginTile(context),
                ChangeTheme(),
                contactTile(context),
                aboutTile(context),
              ],
            ),
          );
      }
      if (snapshot.hasData) {
        UserModel user = snapshot.data!;
        return Container(
          padding: completePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              emailTile(user.email, context),
              ChangeTheme(),
              contactTile(context),
              aboutTile(context),
              logoutTile(context),
            ],
          ),
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
