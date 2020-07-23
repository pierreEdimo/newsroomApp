import 'package:flutter/foundation.dart';

class UserModel {
  final String userName;
  final String passWord;
  final String email;
  final String profession;

  UserModel(
      {@required this.userName,
      @required this.passWord,
      @required this.email,
      @required this.profession});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      userName: json['userName'] as String,
      passWord: json['passWord'] as String,
      email: json['email'] as String,
      profession: json['profession'] as String);

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "passWord": passWord,
        "email": email,
        "profession": profession
      };
}
