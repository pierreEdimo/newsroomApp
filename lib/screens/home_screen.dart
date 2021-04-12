import 'package:newsroom/screens/search_screen.dart';
import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:newsroom/widget/list_of_articles.dart';
import 'package:flutter/material.dart';
import 'package:newsroom/widget/title_row.dart';

class HomeScreen extends StatelessWidget {
  final String url = "https://newsplace.azurewebsites.net/api/Articles/Filter";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        child: titleRow(
            "Home",
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              ),
            ),
            context),
        height: 100,
      ),
      body: listOfArticles(
        url,
        context,
      ),
    );
  }
}
