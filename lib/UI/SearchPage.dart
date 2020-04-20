import 'package:findadoctor/Model/DoctorModel.dart';
import 'package:findadoctor/Service/DoctorService.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final DoctorService doctorService = new DoctorService();
  List<Doctor> doctors = List();
  List<Doctor> filteredDoctors = List();

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
                      .where((u) =>
                          (u.city.toLowerCase().contains(string.toLowerCase())))
                      .toList();
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(filteredDoctors[index].name),
                      subtitle: Text(filteredDoctors[index].city));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
