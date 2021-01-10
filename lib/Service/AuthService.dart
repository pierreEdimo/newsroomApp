import 'package:Newsroom/Model/LoginModel.dart';
import 'package:Newsroom/Model/UserModel.dart';
import 'package:http/http.dart';
import 'dart:convert';

import '../main.dart';

class AuthService {
  Future<int> registerUser(UserModel userModel) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsEncode;
    jsEncode = jsonEncode(userModel);
    final Response response = await post(
        'https://newsplace.azurewebsites.net/api/User/Register',
        headers: headers,
        body: jsEncode);
    if (response.statusCode == 200) {
      String jwt = response.body;
      storage.write(key: "jwt", value: jwt);
    } else if (response.statusCode == 500) {
      return response.statusCode;
    } else {
      throw "Error";
    }
    return response.statusCode;
  }

  Future<int> loginUser(LoginModel loginModel) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsEncode;
    jsEncode = jsonEncode(loginModel);
    final Response response = await post(
        'https://newsplace.azurewebsites.net/api/User/Login',
        headers: headers,
        body: jsEncode);

    if (response.statusCode == 200) {
      String jwt = response.body;
      storage.write(key: "jwt", value: jwt);
    } else if (response.statusCode == 500) {
      return response.statusCode;
    } else {
      throw "error";
    }
    return response.statusCode;
  }

  Future<UserModel> fethSingleUser() async {
    String authorization = await storage.read(key: "jwt");
    final response = await get(
        'https://newsplace.azurewebsites.net/api/User/GetUser',
        headers: {'Authorization': 'Bearer ' + authorization});
    print(authorization);
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      storage.write(key: "userId", value: responseJson['id']);
      print(responseJson['id']);
      return UserModel.fromJson(responseJson);
    }
    return null;
  }
}
