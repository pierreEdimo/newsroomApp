import 'package:findadoctor/Model/DoctorModel.dart';
import 'package:findadoctor/Service/DoctorService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'DoctorDetailPage.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('image/icon.png'),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Doctors",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'),
        ),
        actions: <Widget>[
          IconButton(
            icon:
                FaIcon(FontAwesomeIcons.search, color: Colors.black, size: 18),
            onPressed: () {},
          ),
        ],
      ),
      body: DoctorList(),
    );
  }
}

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final DoctorService doctorService = DoctorService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: doctorService.getAllDoctors(),
        builder: (BuildContext context, AsyncSnapshot<List<Doctor>> snapshot) {
          if (snapshot.hasData) {
            List<Doctor> doctors = snapshot.data;

            return ListView(
                children: doctors
                    .map((Doctor doctor) => Container(
                          child: ListTile(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DoctorDetails(
                                doctor: doctor,
                              ),
                            )),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(doctor.imageUrl),
                            ),
                            title: Text(
                              "Dr.med. ${doctor.name}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans'),
                            ),
                            subtitle: Text(doctor.searchWord),
                          ),
                        ))
                    .toList());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.exclamationTriangle,
                    size: 80,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Text(
                      "Error your phone is not connected to the internet, please try again later",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
