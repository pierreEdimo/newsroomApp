import 'package:Newsroom/Component/Center.Error.dart';
import 'package:Newsroom/Component/Header.dart';
import 'package:Newsroom/Component/Theme.Card.dart';
import 'package:Newsroom/Model/ThemeModel.dart';
import 'package:Newsroom/Service/ThemeService.dart';
import 'package:Newsroom/UI/ThemeDetailScreen.dart';
import 'package:flutter/material.dart';

class CategoriScreen extends StatefulWidget {
  @override
  _CategoriScreenState createState() => _CategoriScreenState();
}

class _CategoriScreenState extends State<CategoriScreen> {
  ThemeService _themeService = ThemeService();
  Future<List<ThemeModel>> _themes;

  @override
  void initState() {
    super.initState();
    _themes = _themeService.getAllThemes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SafeArea(
              child: header("Hot Topics", context),
            ),
            SizedBox(height: 20.0),
            Expanded(
                child: Container(
              child: FutureBuilder(
                future: _themes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ThemeModel> themes = snapshot.data;

                    return ListView(
                      padding: EdgeInsets.all(0.0),
                      children: themes
                          .map(
                            (ThemeModel themeModel) => Container(
                              margin: EdgeInsets.only(bottom: 20.0),
                              child: InkWell(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ThemeDetailScreen(
                                      themeId: themeModel.id,
                                      themeName: themeModel.name,
                                    ),
                                  ),
                                ),
                                child: themeCard(themeModel.name,
                                    themeModel.imageUrl, 500, 32.0, 160),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  } else if (snapshot.hasError) {
                    return centerError();
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
