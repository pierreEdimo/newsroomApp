import 'package:flutter/material.dart';
import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:newsroom/widget/list_of_items.dart';
import 'package:newsroom/widget/title_in_the_center.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(inTheCenter("Settings"), 80.0),
      body: SingleChildScrollView(
        child: listOfItem(context),
      ),
    );
  }
}
