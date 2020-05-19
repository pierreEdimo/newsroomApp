import 'package:findadoctor/Model/UserModel.dart';
import 'package:http/http.dart';
import 'dart:convert';

class AuthService {
  //final String jwtokens;
  //final String userId;

  Future<String> registerUser(UserModel userModel) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsEncode;
    jsEncode = jsonEncode(userModel);
    final Response response = await post(
        'https://findadoc.azurewebsites.net/api/User/Register',
        headers: headers,
        body: jsEncode);

    print(response.body);
    return response.body;
  }
}
