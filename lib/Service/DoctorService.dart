import 'dart:convert';

import 'package:findadoctor/Model/DoctorModel.dart';
import 'package:http/http.dart';

class DoctorService {
  final String doctorUrl = "https://findadoc.azurewebsites.net/api/Doctor";

  Future<List<Doctor>> getAllDoctors() async {
    Response res = await get(doctorUrl);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Doctor> doctors =
          body.map((dynamic item) => Doctor.fromJson(item)).toList();

      return doctors;
    } else {
      throw "can't get a Doctor";
    }
  }
}
