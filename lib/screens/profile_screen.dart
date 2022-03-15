import 'package:flutter/material.dart';
import 'package:newsroom/widget/list_of_items.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: listOfItem(context),
      ),
    );
  }
}
