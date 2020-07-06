import 'package:findadoctor/Model/ThemeModel.dart';
import 'package:findadoctor/Service/ThemeService.dart';
import 'package:findadoctor/UI/ThemeArticle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('image/icon.png'),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Theme",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.search,
              color: Colors.black,
              size: 18,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: ThemeList(),
    );
  }
}

class ThemeList extends StatefulWidget {
  @override
  _ThemeListState createState() => _ThemeListState();
}

class _ThemeListState extends State<ThemeList> {
  final ThemeService themeService = new ThemeService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: themeService.getAllThemes(),
          builder:
              (BuildContext context, AsyncSnapshot<List<ThemeModel>> snapshot) {
            if (snapshot.hasData) {
              List<ThemeModel> themes = snapshot.data;
              return ListView(
                padding: EdgeInsets.all(10),
                children: themes
                    .map((ThemeModel theme) => Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ThemeArticleList(
                                            themeData: theme,
                                          )));
                            },
                            child: Center(
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    width: 500,
                                    height: 300,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(theme.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 500,
                                    height: 300,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Color.fromRGBO(0, 0, 0, 0.4)),
                                  ),
                                  Container(
                                    width: 500,
                                    height: 300,
                                    alignment: Alignment.center,
                                    child: Text(
                                      theme.name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0,
                                          fontFamily: 'OpenSans'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              );
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.exclamationTriangle,
                        size: 80,
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Text(
                          "Error your phone is not connected to the internet, please try again later",
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
