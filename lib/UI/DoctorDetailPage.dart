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
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          color: Colors.black,
          iconSize: 18,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Dr. med ${doctor.name}",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 400,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(doctor.imageUrl), fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 10.0,
          ),
          Card(
            child: Container(
              color: Color.fromRGBO(246, 246, 246, 1.0),
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "Profession : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        doctor.specialisation,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Adress : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        doctor.location,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "City : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${doctor.poBox}, ${doctor.city}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Country : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        doctor.country,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Tel. : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        doctor.number,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Email : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        doctor.email,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Openings: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "${doctor.opening}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "${doctor.closing}",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Card(
            child: Container(
                color: Color.fromRGBO(246, 246, 246, 0.9),
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Biographie",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        doctor.description,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
