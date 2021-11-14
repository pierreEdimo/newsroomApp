import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:newsroom/model/edit_email.dart';
import 'package:newsroom/model/loginModel.dart';
import 'package:newsroom/model/registerModel.dart';
import 'package:newsroom/model/user_,model.dart';
import 'dart:convert';

import '../main.dart';

class AuthService extends ChangeNotifier {
  var box = Hive.box('userId');

  Future<Response> registerUser(RegisterModel userModel) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsEncode;
    jsEncode = jsonEncode(userModel);
    var url =
        Uri.parse('https://newsplace.azurewebsites.net/api/User/Register');
    final Response response = await post(
      url,
      headers: headers,
      body: jsEncode,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      storage.write(key: "userId", value: responseJson['userDto']['id']);
      box.put('userId', responseJson['userDto']['id']);
      storage.write(key: "jwt", value: responseJson['token']);
      notifyListeners();
      //storage.write(key: "jwt", value: jwt);
    }
    return response;
  }

  Future<Response> loginUser(LoginModel loginModel) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsEncode;
    jsEncode = jsonEncode(loginModel);
    var url = Uri.parse('https://newsplace.azurewebsites.net/api/User/Login');
    final Response response = await post(
      url,
      headers: headers,
      body: jsEncode,
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      storage.write(key: "userId", value: responseJson['userDto']['id']);
      box.put('userId', responseJson['userDto']['id']);
      storage.write(key: "jwt", value: responseJson['token']);
      notifyListeners();
    }

    return response;
  }

  Future<Response> resetPassword(LoginModel login) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String jsEncode = jsonEncode(login);
    var url = Uri.parse(
        'https://newsplace.azurewebsites.net/api/User/ForgotPassWord');
    final Response response = await post(
      url,
      headers: headers,
      body: jsEncode,
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      storage.write(key: "userId", value: responseJson['userDto']['id']);
      box.put('userId', responseJson['userDto']['id']);
      storage.write(key: "jwt", value: responseJson['token']);
      notifyListeners();
    }
    return response;
  }

  Future<Response> editEmail(EditEmail email) async {
    String? authorization = await storage.read(key: "jwt");
    String jsEncode = jsonEncode(email);
    var url =
        Uri.parse('https://newsplace.azurewebsites.net/api/User/updateEmail');
    final Response response = await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + authorization!,
      },
      body: jsEncode,
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      storage.write(key: "userId", value: responseJson['userDto']['id']);
      box.put('userId', responseJson['userDto']['id']);
      storage.write(key: "jwt", value: responseJson['token']);
      notifyListeners();
    }
    return response;
  }

  Future<UserModel> fethSingleUser() async {
    String? authorization = await storage.read(key: "jwt");
    var url = Uri.parse('https://newsplace.azurewebsites.net/api/User/GetUser');
    final response =
        await get(url, headers: {'Authorization': 'Bearer ' + authorization!});
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return UserModel.fromJson(responseJson);
    }
    throw "could not fetch the User";
  }
}
