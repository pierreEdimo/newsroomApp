import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
            size: 18,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: new TextField(
            style: TextStyle(color: Colors.black, fontSize: 22),
            decoration: InputDecoration(
              hintText: "Search for a doctor",
              hintStyle: TextStyle(color: Colors.black, fontSize: 22.0),
            )),
      ),
      body: Center(
        child: Text("Hello Search for a doctor"),
      ),
    );
  }
}
