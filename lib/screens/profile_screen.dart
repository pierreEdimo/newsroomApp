import 'package:flutter/material.dart';
import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:newsroom/widget/list_of_items.dart';
import 'package:newsroom/widget/profile_title_row.dart';



class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(profileTitleRow()),
      body: SingleChildScrollView(
        child: listOfItem(context),
      ),
    );
  }
}
