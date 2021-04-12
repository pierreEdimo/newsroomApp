import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:newsroom/model/edit_email.dart';
import 'package:newsroom/model/loginModel.dart';
import 'package:newsroom/model/userModel.dart';
import 'dart:convert';

import '../main.dart';

class AuthService extends ChangeNotifier {
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
    } else if (response.statusCode != 500) {
      print(response.statusCode);
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
    } else if (response.statusCode != 200) {
      return response.statusCode;
    } else {
      throw "Error";
    }
    return response.statusCode;
  }

  Future<Response> editEmail(EditEmail email) async {
    String authorization = await storage.read(key: "jwt");
    String jsEncode;
    jsEncode = jsonEncode(email);
    final Response response =
        await post('https://newsplace.azurewebsites.net/api/User/updateEmail',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ' + authorization,
            },
            body: jsEncode);

    if (response.statusCode == 200) {
      String jwt = response.body;
      storage.write(key: "jwt", value: jwt);
      notifyListeners();
    }
    return response;
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
      return UserModel.fromJson(responseJson);
    }
    return null;
  }
}
