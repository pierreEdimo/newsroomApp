import 'package:findadoctor/Model/ThemeModel.dart';
import 'package:findadoctor/Service/ThemeService.dart';
import 'package:findadoctor/UI/ThemeArticle.dart';
import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemeStatePage createState() => _ThemeStatePage();
}

class _ThemeStatePage extends State<ThemePage> {
  final ThemeService themeService = new ThemeService();
  List<ThemeModel> _themes = List();
  List<ThemeModel> filteredThemes = List();

  @override
  void initState() {
    super.initState();
    themeService.getAllThemes().then((themes) {
      setState(() {
        _themes = themes;
        filteredThemes = _themes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 52.5, left: 20, right: 20),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintText: "Search for a theme",
                hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
            onChanged: (string) {
              setState(() {
                filteredThemes = _themes
                    .where((u) =>
                        (u.name.toLowerCase().contains(string.toLowerCase())))
                    .toList();
              });
            },
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filteredThemes.length,
                itemBuilder: (BuildContext context, int index) {
                  ThemeModel themA = filteredThemes[index];
                  return Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ThemeArticleList(
                                        themeData: themA,
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
                                        image: NetworkImage(themA.imageUrl),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
                              Container(
                                alignment: Alignment.center,
                                width: 500,
                                height: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Color.fromRGBO(0, 0, 0, 0.4)),
                              ),
                              Container(
                                width: 500,
                                height: 300,
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text(
                                    themA.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
                }),
          )
        ],
      ),
    ));
  }
}
