import 'package:flutter/material.dart';

Widget text(String text, double size, Color color) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
  );
}

Widget customCard(String title, String imageUrl, double width, double fontSize,
    double height, String authorName, String entryDate) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        text('by $authorName. ', 12.0, Colors.white70),
                        SizedBox(
                          width: 2.0,
                        ),
                        text('Added on $entryDate', 12.0, Colors.white70),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Flexible(
                child: Container(
                  alignment: Alignment.bottomLeft,
                  height: 58,
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                          fontSize: fontSize),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
