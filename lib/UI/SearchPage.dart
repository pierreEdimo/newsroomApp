import 'package:findadoctor/Model/DoctorModel.dart';
import 'package:findadoctor/Service/DoctorService.dart';
import 'package:flutter/material.dart';

import 'DoctorDetailPage.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final DoctorService doctorService = new DoctorService();
  List<Doctor> doctors = List();
  List<Doctor> filteredDoctors = List();
  String searchWord;

  @override
  void initState() {
    super.initState();
    doctorService.getAllDoctors().then((doctorFromServer) {
      setState(() {
        doctors = doctorFromServer;
        filteredDoctors = doctors;
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
                  hintText: "Search a Doctor",
                  hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
              onChanged: (string) {
                setState(() {
                  filteredDoctors = doctors
                      .where((u) => (u.searchWord
                          .toLowerCase()
                          .contains(string.toLowerCase())))
                      .toList();
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DoctorDetails(doctor: filteredDoctors[index]))),
                    child: Container(
                        child: Row(
                      children: <Widget>[
                        Container(
                          width: 75,
                          height: 75,
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          height: 75,
                          width: 230,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Dr. med. ${filteredDoctors[index].name}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                    "${filteredDoctors[index].searchWord}"),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
