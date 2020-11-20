import 'package:flutter/material.dart';

Widget text(String text) {
  return Text(
    text,
    style: TextStyle(color: Colors.white, fontSize: 13.0),
  );
}

Widget themeCard(
  String title,
  String imageUrl,
  double width,
  double fontSize,
  double height,
) {
  return Container(
    child: Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(imageUrl), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 2),
              )
            ],
          ),
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color.fromRGBO(0, 0, 0, 0.4),
          ),
        ),
        Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: 58,
            child: Container(
              alignment: Alignment.topLeft,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      fontSize: fontSize),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
