import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchEnginePage extends StatefulWidget {
  @override
  _SearchEnginePageState createState() => _SearchEnginePageState();
}

class _SearchEnginePageState extends State<SearchEnginePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "findAdoctor",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Text("Search A doctor"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Hello World");
          },
          child: FaIcon(
            FontAwesomeIcons.newspaper,
            size: 18,
          ),
          backgroundColor: Colors.blue),
    );
  }
}
