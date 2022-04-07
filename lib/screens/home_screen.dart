import 'package:newsroom/model/article.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/home_article_container.dart';
import 'package:newsroom/widget/list_of_articles.dart';
import 'package:flutter/material.dart';
import 'package:newsroom/widget/search_icon.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final String url = "https://newsplace.azurewebsites.net/api/Articles";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Newsroom",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [searchIcon(context)],
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
                  child: Text("Latest Articles", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    fontFamily: 'OpenSansBold'
                  ),),
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
