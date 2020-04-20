import 'package:findadoctor/Model/DoctorModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorDetails extends StatelessWidget {
  final Doctor doctor;

  DoctorDetails({Key key, @required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          color: Colors.black,
          iconSize: 18,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Dr. med ${doctor.name}",
          style: TextStyle(fontSize: 25.0, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 100,
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 131,
                          alignment: Alignment.topLeft,
                          child: Text(doctor.specialisation)),
                      Text(
                        "Am ${doctor.location},",
                      ),
                      Container(
                          width: 131,
                          alignment: Alignment.topLeft,
                          child: Text("36043, ${doctor.city}, ")),
                      Container(
                          width: 131,
                          alignment: Alignment.topLeft,
                          child: Text(doctor.country))
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 180,
                          alignment: Alignment.topRight,
                          child: Text("Tel: ${doctor.number}")),
                      Text("Email: ${doctor.email}"),
                      Container(
                          width: 180,
                          alignment: Alignment.topRight,
                          child: Text("Von: ${doctor.opening}")),
                      Container(
                          width: 180,
                          alignment: Alignment.topRight,
                          child: Text("bis: ${doctor.closing}"))
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            child: Text("Bio: ${doctor.description}"),
          )
        ],
      ),
    );
  }
}
