import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/home_article_container.dart';
import 'package:flutter/material.dart';
import 'package:newsroom/widget/standard_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String url = "https://newsplace.azurewebsites.net/api/Articles/Filter?sortBy=createdAt";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance
        .getToken()
        .then((value) => print("token:  $value"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(
        title: "TheRoom",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 120,
              color: Colors.red,
            ),
            Container(
              child: HomeArticleContainer(
                child: Padding(
                  padding: horizontalPadding,
                  child: Text(
                    "Recently added",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
                shrinkWrap: true,
                url: url,
              ),
            )
          ],
        ),
      ),
    );
  }
}
