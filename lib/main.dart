import 'package:flutter/material.dart';

import 'UI/SearchEngine.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'findadoctor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Pacifico', scaffoldBackgroundColor: Colors.white),
        home: SearchEnginePage());
  }
}
