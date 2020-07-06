import 'package:findadoctor/Model/LoginModel.dart';
import 'package:findadoctor/Model/UserModel.dart';
import 'package:http/http.dart';
import 'dart:convert';

import '../main.dart';

class AuthService {
  Future<int> registerUser(UserModel userModel) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsEncode;
    jsEncode = jsonEncode(userModel);
    final Response response = await post(
        'https://findadoc.azurewebsites.net/api/User/Register',
        headers: headers,
        body: jsEncode);
    if (response.statusCode == 200) {
      String jwt = response.body;
      storage.write(key: "jwt", value: jwt);
      return response.statusCode;
    } else {
      throw "Error";
    }
  }

  Future<String> loginUser(LoginModel loginModel) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsEncode;
    jsEncode = jsonEncode(loginModel);
    final Response response = await post(
        'https://findadoc.azurewebsites.net/api/User/Login',
        headers: headers,
        body: jsEncode);

    if (response.statusCode == 200) {
      String jwt = response.body;
      storage.write(key: "jwt", value: jwt);
      return response.body;
    } else {
      throw "Error ";
    }
  }

  Future<UserModel> fethSingleUser() async {
    String authorization = await storage.read(key: "jwt");
    final response = await get(
        'https://findadoc.azurewebsites.net/api/User/GetUser',
        headers: {'Authorization': 'Bearer ' + authorization});
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson['id']);
      return UserModel.fromJson(responseJson);
    } else {
      print(response.statusCode);
    }
    return null;
  }
}
