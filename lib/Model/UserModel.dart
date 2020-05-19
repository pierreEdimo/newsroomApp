import 'package:flutter/foundation.dart';

class UserModel {
  final String userName;
  final String phoneNumber;
  final String location;
  final String city;
  final String country;
  final String poBox;
  final String passWord;
  final String email;
  final String firstName;
  final String lastName;

  UserModel({
    @required this.userName,
    @required this.phoneNumber,
    @required this.location,
    @required this.city,
    @required this.country,
    @required this.poBox,
    @required this.passWord,
    @required this.email,
    @required this.firstName,
    @required this.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userName: json['userName'] as String,
        phoneNumber: json['phoneNumber'] as String,
        location: json['location'] as String,
        city: json['city'] as String,
        poBox: json['poBox'] as String,
        passWord: json['passWord'] as String,
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        country: json['country'] as String,
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "phoneNumber": phoneNumber,
        "location": location,
        "city": city,
        "poBox": poBox,
        "passWord": passWord,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "country": country
      };
}
