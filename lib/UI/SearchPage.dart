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
  //String searchWord;
  Widget appBarTitle =
      new Text("findadoctor", style: TextStyle(color: Colors.black));
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.black,
  );

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
      appBar: AppBar(
        leading: Image.asset('image/icon.png'),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = Icon(
                    Icons.close,
                    color: Colors.black,
                  );
                  this.appBarTitle = Center(
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      onChanged: (string) {
                        setState(() {
                          filteredDoctors = doctors
                              .where((element) => (element.searchWord
                                  .toLowerCase()
                                  .contains(string.toLowerCase())))
                              .toList();
                        });
                      },
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                  );
                } else {
                  this.actionIcon = Icon(
                    Icons.search,
                    color: Colors.black,
                  );
                  this.appBarTitle = Text(
                    "findadoctor",
                    style: TextStyle(color: Colors.black),
                  );
                }
              });
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DoctorDetails(doctor: filteredDoctors[index]))),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(filteredDoctors[index].imageUrl),
                    ),
                    title: Text(
                      "Dr.med. ${filteredDoctors[index].name}",
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(filteredDoctors[index].searchWord),
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
