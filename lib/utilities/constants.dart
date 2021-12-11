import 'package:flutter/material.dart';

const titleStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  fontFamily: 'OpenSansBold',
);

const smallText = TextStyle(fontSize: 11.0);

const horizontalSpace = SizedBox(width: 20.0);

const nameAndDateStyle = TextStyle(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSansBold');

const verticalSpace = SizedBox(height: 20.0);

EdgeInsets standardPadding = EdgeInsets.symmetric(
  vertical: 10.0,
  horizontal: 25.0,
);

EdgeInsets completePadding =
    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0);

EdgeInsets horizontalPadding = EdgeInsets.symmetric(horizontal: 20.0);

EdgeInsets verticalPadding =
    EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0);

EdgeInsets all25Padding = EdgeInsets.all(25.0);

String unloggedTextError = "Sorry you need to be logged in " + "\n";

final lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100,
  Colors.amberAccent.shade100,
  Colors.blueAccent.shade100,
  Colors.blue.shade300,
  Colors.redAccent.shade100,
  Colors.teal.shade300,
  Colors.red.shade300,
  Colors.deepPurple.shade300,
  Colors.orangeAccent.shade100,
  Colors.limeAccent.shade100,
  Colors.indigo.shade300,
  Colors.cyan.shade300,
  Colors.purpleAccent.shade100,
];
